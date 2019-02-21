Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Thu, 21 Feb 2019 13:12:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] zcrypt: handle AP Info notification from CHSC SEI
 command
Message-ID: <20190221131240.0ab463d1.cohuck@redhat.com>
In-Reply-To: <d0e1ef87-8fc7-ea13-3dba-6abf1a28a446@linux.ibm.com>
References: <1548870526-30595-1-git-send-email-akrowiak@linux.ibm.com>
        <alpine.LFD.2.21.1901301912380.2372@schleppi>
        <d0e1ef87-8fc7-ea13-3dba-6abf1a28a446@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Sebastian Ott <sebott@linux.ibm.com>, Tony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, oberpar@linux.ibm.com, pmorel@linux.ibm.com, pasic@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 21 Feb 2019 11:42:25 +0100
Harald Freudenberger <freude@linux.ibm.com> wrote:

> On 30.01.19 19:32, Sebastian Ott wrote:
> > On Wed, 30 Jan 2019, Tony Krowiak wrote:  

> >>  /*
> >> +* A config change has happened, Force an ap bus rescan.
> >> +*/
> >> +void ap_bus_cfg_chg(void)
> >> +{
> >> +	AP_DBF(DBF_INFO, "%s config change, forcing bus rescan\n", __func__);
> >> +
> >> +	ap_bus_force_rescan();
> >> +}
> >> +EXPORT_SYMBOL(ap_bus_cfg_chg);  
> > There is no need for the export symbol - you don't call that function
> > from module code.  
> That's what I have learned now: You don't need to export a symbol
> as long as the symbol is only called in static code parts of the kernel.
> But you need to export it when it is intended to be used by code
> which sits in a kernel module. So now the big question:
> How does a provider of a function in the kernel know, if the caller is in static
> code or in module code ? And ... maybe this may even change over
> the time. So my recommendation is to always export the symbol with
> the EXPORT_SYMBOL macro. This way you don't need to change the
> code providing a function when the caller code changes or additional
> code uses the symbol.
> 
> Other opinions ?

Well, if you know it will be called from module code in upcoming
patches, export it. If not, I consider it the choice of the maintainer.
You can easily add the export later on, if needed, anyway, and I don't
consider changing the code a problem.

In this particular case, both exporting and not exporting looked like
reasonable choices to me.
