Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1439973050.12322.5.camel@BR9GV9YG.de.ibm.com>
Subject: Re: [PATCH] qeth: Convert use of __constant_htons to htons
From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Date: Wed, 19 Aug 2015 10:30:50 +0200
In-Reply-To: <OF92C6D110.21C79ACA-ONC1257EA6.002BFA53-C1257EA6.002C1CD6@de.ibm.com>
References: <OF92C6D110.21C79ACA-ONC1257EA6.002BFA53-C1257EA6.002C1CD6@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Vaishali Thakkar <vthakkar1994@gmail.com>
Cc: mschwid2@linux.vnet.ibm.com, heicars2@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Linux390@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>


> From:        Vaishali Thakkar <vthakkar1994@gmail.com> 
> To:        Ursula Braun <ubraun@linux.vnet.ibm.com>, 
> Cc:        Ursula Braun1/Germany/IBM@IBMDE, BOEBLINGEN
> LINUX390/Germany/IBM@IBMDE, mschwid2@linux.vnet.ibm.com,
> heicars2@linux.vnet.ibm.com, linux-s390@vger.kernel.org, Linux Kernel
> Mailing List <linux-kernel@vger.kernel.org> 
> Date:        19/08/2015 07:02 
> Subject:        Re: [PATCH] qeth: Convert use of __constant_htons to
> htons 
> 
> ______________________________________________________________________
> 
> 
> 
> On Fri, Jun 12, 2015 at 1:12 PM, Ursula Braun
> <ubraun@linux.vnet.ibm.com> wrote:
> > Thanks Vaishali. I have added your patch to our local kernel git,
> and
> > will submit it within a following upstream shipment.
> 
> Hi Ursula,
> 
> Can you please tell me when this patch is going to be added in
> linux-next? I don't see them in linux-next and they are blocking
> removal of these macros.
> 
> Do inform me in case there is any problem with this patch.
> 
> Thank You.
> 
Hi Vaishali,

sorry, I have not been aware that you are urgently waiting for my next
upstream posting. I shipped your patch a few minutes ago to Dave Miller
for inclusion into net-next.

Regards, Ursula Braun
