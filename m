Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60586 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727312AbgBZUgb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 Feb 2020 15:36:31 -0500
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01QKP7FD143212
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 15:36:30 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ydqbt2g6w-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 26 Feb 2020 15:36:29 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <zohar@linux.ibm.com>;
        Wed, 26 Feb 2020 20:36:27 -0000
Subject: Re: [PATCH] ima: add a new CONFIG for loading arch-specific policies
From: Mimi Zohar <zohar@linux.ibm.com>
Date: Wed, 26 Feb 2020 15:36:19 -0500
In-Reply-To: <94fe39a9-db9e-211d-d9b7-4cfe1a270e6f@linux.microsoft.com>
References: <1582744207-25969-1-git-send-email-nayna@linux.ibm.com>
         <94fe39a9-db9e-211d-d9b7-4cfe1a270e6f@linux.microsoft.com>
Content-Type: text/plain; charset="utf-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <1582749379.10443.246.camel@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>, Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-efi@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Philipp Rudo <prudo@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, linux-kernel@vger.kernel.org

On Wed, 2020-02-26 at 11:21 -0800, Lakshmi Ramasubramanian wrote:
> Hi Nayna,
> 
> > +
> > +config IMA_SECURE_AND_OR_TRUSTED_BOOT
> > +	bool
> > +	depends on IMA
> > +	depends on IMA_ARCH_POLICY
> > +	default n
> > +	help
> > +	   This option is selected by architectures to enable secure and/or
> > +	   trusted boot based on IMA runtime policies.
> > 
> 
> Why is the default for this new config "n"?
> Is there any reason to not turn on this config if both IMA and 
> IMA_ARCH_POLICY are set to y?

Good catch.  Having "IMA_SECURE_AND_OR_TRUSTED_BOOT" depend on
"IMA_ARCH_POLICY" doesn't make sense.  "IMA_ARCH_POLICY" needs to be
selected.

thanks,

Mimi
