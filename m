Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.133]:36524 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389923AbfGOOUq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 15 Jul 2019 10:20:46 -0400
Date: Mon, 15 Jul 2019 07:20:45 -0700
From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 1/1] s390/protvirt: restore force_dma_unencrypted()
Message-ID: <20190715142045.GA908@infradead.org>
References: <20190715131719.100650-1-pasic@linux.ibm.com>
 <20190715132027.GA18357@infradead.org>
 <7e393b48-4165-e1d4-0450-e52dd914a3cd@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e393b48-4165-e1d4-0450-e52dd914a3cd@amd.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Lendacky, Thomas" <Thomas.Lendacky@amd.com>
Cc: Christoph Hellwig <hch@infradead.org>, Halil Pasic <pasic@linux.ibm.com>, "kvm@vger.kernel.org" <kvm@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Thiago Jung Bauermann <bauerman@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>

Ok,

I've folded the minimal s390 fix in, please both double check that this
is ok as the minimally invasive fix:

http://git.infradead.org/users/hch/dma-mapping.git/commitdiff/7bb9bbcee8845af663a7a60df9e2cc24422b3de5

The s390 fix to clean up sev_active can then go into the series that
Thiago is working on.
