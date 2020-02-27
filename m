Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] ima: add a new CONFIG for loading arch-specific policies
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Thu, 27 Feb 2020 14:38:09 -0500
In-Reply-To: <1582749379.10443.246.camel@linux.ibm.com>
References: <1582744207-25969-1-git-send-email-nayna@linux.ibm.com>
         <94fe39a9-db9e-211d-d9b7-4cfe1a270e6f@linux.microsoft.com>
         <1582749379.10443.246.camel@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <1582832289.10443.298.camel@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-efi@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org

On Wed, 2020-02-26 at 15:36 -0500, Mimi Zohar wrote:
> On Wed, 2020-02-26 at 11:21 -0800, Lakshmi Ramasubramanian wrote:
> > Hi Nayna,
> > 
> > > +
> > > +config IMA_SECURE_AND_OR_TRUSTED_BOOT
> > > +	bool
> > > +	depends on IMA
> > > +	depends on IMA_ARCH_POLICY
> > > +	default n
> > > +	help
> > > +	   This option is selected by architectures to enable secure and/or
> > > +	   trusted boot based on IMA runtime policies.
> > > 
> > 
> > Why is the default for this new config "n"?
> > Is there any reason to not turn on this config if both IMA and 
> > IMA_ARCH_POLICY are set to y?
> 
> Good catch.  Having "IMA_SECURE_AND_OR_TRUSTED_BOOT" depend on
> "IMA_ARCH_POLICY" doesn't make sense.  "IMA_ARCH_POLICY" needs to be
> selected.

After discussing this some more with Nayna, the new Kconfig indicates
that the architecture defines the arch_ima_get_secureboot() and
arch_get_ima_policy() functions, but doesn't automatically enable
IMA_ARCH_POLICY.  The decision to enable IMA_ARCH_POLICY is left up to
whoever is building the kernel.  The patch, at least this aspect of
it, is correct.

Mimi
