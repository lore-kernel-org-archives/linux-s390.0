Return-Path: <linux-kernel-owner+w=401wt.eu-S1757996AbYGAOpX@vger.kernel.org>
Date: Tue, 1 Jul 2008 16:44:30 +0200
From: Christof Schmitt <christof.schmitt@de.ibm.com>
Subject: Re: [patch 5/5] zfcp: adapt to new qdio driver
Message-ID: <20080701144429.GA13260@schmichrtp.de.ibm.com>
References: <20080701140551.168274793@de.ibm.com> <20080701140625.489478465@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080701140625.489478465@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, jang@linux.vnet.ibm.com, Swen Schillig <swen@vnet.ibm.com>, James Bottomley <James.Bottomley@HansenPartnership.com>
List-ID: <linux-s390.vger.kernel.org>

On Tue, Jul 01, 2008 at 04:05:56PM +0200, Martin Schwidefsky wrote:
> From: Jan Glauber <jang@linux.vnet.ibm.com>
> 
> - cleanup qdio interface error handling
> - remove qdio interface threshold values
> - remove do_QDIO unused last parameter
> - no more -EINPROGRESS from qdio_shutdown()
> - remove unused parameter from qdio_activate()
> - remove QDIO_FLAG_UNDER_INTERRUPT
> 
> Cc: Swen Schillig <swen@vnet.ibm.com>
> Cc: Christof Schmitt <christof.schmitt@de.ibm.com>
> Cc: James Bottomley <James.Bottomley@HansenPartnership.com>
> 
> Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

ACK

Christof
