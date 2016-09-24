library("shiny")
library("ggplot2")
library("scales")

#define function for determining bid price
rightbid <- function(repaircost,monthcost,months,sellprice,return) (repaircost+(monthcost*months)-sellprice)/(-1*(1+(return*.01)))

shinyServer(function(input, output) {
   
        #calculate min bid
        output$bid.low <- renderPrint({noquote(dollar(round(rightbid(input$repaircost[2],input$monthcost,input$months,input$sellprice,input$return),digits=0)))})
        
        # Calculate max bd
        output$bid.high <- renderPrint({noquote(dollar(round(rightbid(input$repaircost[1],input$monthcost,input$months,input$sellprice,input$return),digits=0)))})
        
        #Run dynamic bid calculations, then plot max, min and median bids as horizontal lines; return % as a vertical line
        output$plot <- renderPlot({
                Minimum_Bid <- rightbid(input$repaircost[2],input$monthcost,input$months,input$sellprice,input$return)
                Maximum_Bid <- rightbid(input$repaircost[1],input$monthcost,input$months,input$sellprice,input$return)
                Median_Bid <- mean(Minimum_Bid,Maximum_Bid)
                data <- data.frame("Return" = rep(input$return,3),"Bid" = c(Minimum_Bid,mean(Minimum_Bid,Maximum_Bid),Maximum_Bid))
                return.p <- input$return
                sellprice.p <- input$sellprice
                
                g <- ggplot(data,aes(Return,Bid)) + 
                ylim(0,sellprice.p) + 
                scale_x_continuous(limits=c(0,100),breaks=seq(0,100,10)) +
                geom_hline(aes(yintercept=mean(c(Minimum_Bid,Maximum_Bid)),color="Median Bid"),size=2,linetype="solid") + 
                geom_hline(aes(yintercept=Minimum_Bid,color="Minimum Bid"),size=1,linetype="dotted",show.legend=TRUE) + 
                geom_hline(aes(yintercept=Maximum_Bid,color="Maximum Bid"),size=1,linetype="dotted",show.legend=TRUE) + 
                geom_vline(aes(xintercept=return.p,color="Return %"),size=1,linetype="dotdash") +
                theme(legend.position = "right") +
                scale_color_manual(values=c("Median Bid" = "black","Minimum Bid" = "blue","Maximum Bid" = "green","Return %" = "red")) +
                labs(title="Bid Range",x="Return (%)",y="Bid Amount ($)",colour="Bid and Return Guides")
                g


        })

  
})
