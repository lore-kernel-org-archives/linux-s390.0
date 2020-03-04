Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:35696 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388222AbgCDPfg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Mar 2020 10:35:36 -0500
Message-ID: <1583336133.3284.1.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] ima: add a new CONFIG for loading arch-specific
 policies
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Wed, 04 Mar 2020 07:35:33 -0800
In-Reply-To: <1583325309.6264.23.camel@linux.ibm.com>
References: <1583289211-5420-1-git-send-email-nayna@linux.ibm.com>
         <1583307813.3907.4.camel@HansenPartnership.com>
         <1583325309.6264.23.camel@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Mimi Zohar <zohar@linux.ibm.com>, Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-efi@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Philipp Rudo <prudo@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org

On Wed, 2020-03-04 at 07:35 -0500, Mimi Zohar wrote:
> On Tue, 2020-03-03 at 23:43 -0800, James Bottomley wrote:
> > On Tue, 2020-03-03 at 21:33 -0500, Nayna Jain wrote:
> > > diff --git a/security/integrity/ima/Kconfig
> > > b/security/integrity/ima/Kconfig
> > > index 3f3ee4e2eb0d..d17972aa413a 100644
> > > --- a/security/integrity/ima/Kconfig
> > > +++ b/security/integrity/ima/Kconfig
> > > @@ -327,3 +327,12 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
> > >  	depends on IMA_MEASURE_ASYMMETRIC_KEYS
> > >  	depends on SYSTEM_TRUSTED_KEYRING
> > >  	default y
> > > +
> > > +config IMA_SECURE_AND_OR_TRUSTED_BOOT
> > > +	bool
> > > +	depends on IMA
> > > +	depends on IMA_ARCH_POLICY
> > > +	default n
> > 
> > You can't do this: a symbol designed to be selected can't depend on
> > other symbols because Kconfig doesn't see the dependencies during
> > select.  We even have a doc for this now:
> > 
> > Documentation/kbuild/Kconfig.select-break
> 
> The document is discussing a circular dependency, where C selects B.
>  IMA_SECURE_AND_OR_TRUSTED_BOOT is not selecting anything, but is
> being selected.  All of the Kconfig's are now dependent on
> IMA_ARCH_POLICY being enabled before selecting
> IMA_SECURE_AND_OR_TRUSTED_BOOT.
> 
> As Ard pointed out, both IMA and IMA_ARCH_POLICY are not needed, as
> IMA_ARCH_POLICY is already dependent on IMA.

Then removing them is fine, if they're not necessary ... you just can't
 select a symbol with dependencies because the two Kconfig mechanisms
don't mix.

James
