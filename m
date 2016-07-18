Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 18 Jul 2016 09:00:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/pci: Delete an unnecessary check before the
 function call "pci_dev_put"
In-Reply-To: <b46227fb-5a08-7c09-5fe8-facace841880@users.sourceforge.net>
References: <5307CAA2.8060406@users.sourceforge.net>
	<alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
	<530A086E.8010901@users.sourceforge.net>
	<alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
	<530A72AA.3000601@users.sourceforge.net>
	<alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
	<530B5FB6.6010207@users.sourceforge.net>
	<alpine.DEB.2.10.1402241710370.2074@hadrien>
	<530C5E18.1020800@users.sourceforge.net>
	<alpine.DEB.2.10.1402251014170.2080@hadrien>
	<530CD2C4.4050903@users.sourceforge.net>
	<alpine.DEB.2.10.1402251840450.7035@hadrien>
	<530CF8FF.8080600@users.sourceforge.net>
	<alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
	<530DD06F.4090703@users.sourceforge.net>
	<alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
	<5317A59D.4@users.sourceforge.net>
	<b46227fb-5a08-7c09-5fe8-facace841880@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20160718090056.2ab0afce@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Gerald =?UTF-8?B?U2Now6RmZXI=?= <gerald.schaefer@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

On Sat, 16 Jul 2016 20:40:23 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 16 Jul 2016 20:15:17 +0200
> 
> The pci_dev_put() function tests whether its argument is NULL and then
> returns immediately. Thus the test around the call is not needed.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  arch/s390/pci/pci_event.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/s390/pci/pci_event.c b/arch/s390/pci/pci_event.c
> index fb2a9a5..c2b27ad 100644
> --- a/arch/s390/pci/pci_event.c
> +++ b/arch/s390/pci/pci_event.c
> @@ -145,8 +145,7 @@ static void __zpci_event_availability(struct zpci_ccdf_avail *ccdf)
>  	default:
>  		break;
>  	}
> -	if (pdev)
> -		pci_dev_put(pdev);
> +	pci_dev_put(pdev);
>  }
> 
>  void zpci_event_availability(void *data)

Applied,  thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
