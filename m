From: Ursula Braun1 <BRAUNU@de.ibm.com>
Date: Tue, 12 Feb 2008 12:39:00 +0000
Subject: Re: [PATCH] S390:  Use shorter form of "get_zeroed_page".
Message-Id: <OFAD4FA371.7998893F-ONC12573ED.0045062F-C12573ED.00457D4B@de.ibm.com>
In-Reply-To: <alpine.LFD.1.00.0802101552420.15476@localhost.localdomain>
References: <alpine.LFD.1.00.0802101552420.15476@localhost.localdomain>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Robert,

thanks for your qeth-patch. We have already included your patch into our
local kernel repository. Since we are currently on the way to replace the
current qeth-driver by a reworked qeth-driver, you will see your patch
included once the reworked qeth driver is upstream.

Regards, Ursula Braun
IBM Germany, Linux on System z Dev.

IBM Deutschland Entwicklung GmbH
Vorsitzender des Aufsichtsrats: Martin Jetter
Gesch�ftsf�hrung: Herbert Kircher
Sitz der Gesellschaft: B�blingen
Registergericht: Amtsgericht Stuttgart, HRB 243294



                                                                           
             "Robert P. J.                                                 
             Day"                                                          
             <rpjday@crashcour                                          To 
             se.ca>                    linux-s390@vger.kernel.org          
             Sent by:                                                   cc 
             linux-s390-owner@                                             
             vger.kernel.org                                       Subject 
                                       [PATCH] S390:  Use shorter form of  
                                       "get_zeroed_page".                  
             10.02.2008 21:53                                              
                                                                           
                                                                           
                                                                           
                                                                           
                                                                           





Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

diff --git a/drivers/s390/net/qeth_eddp.c b/drivers/s390/net/qeth_eddp.c
index e3c268c..556e8ba 100644
--- a/drivers/s390/net/qeth_eddp.c
+++ b/drivers/s390/net/qeth_eddp.c
@@ -564,14 +564,13 @@ qeth_eddp_create_context_generic(struct qeth_card
*card, struct sk_buff *skb,
                         return NULL;
             }
             for (i = 0; i < ctx->num_pages; ++i){
-                        addr = (u8 *)__get_free_page(GFP_ATOMIC);
+                        addr = (u8 *)get_zeroed_page(GFP_ATOMIC);
                         if (addr == NULL){
                                     QETH_DBF_TEXT(trace, 2, "ceddpcn3");
                                     ctx->num_pages = i;
                                     qeth_eddp_free_context(ctx);
                                     return NULL;
                         }
-                        memset(addr, 0, PAGE_SIZE);
                         ctx->pages[i] = addr;
             }
             ctx->elements = kcalloc(ctx->num_elements,
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

Home page:                                         http://crashcourse.ca
Fedora Cookbook:    http://crashcourse.ca/wiki/index.php/Fedora_Cookbook
========================================================================
