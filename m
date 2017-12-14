Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Thu, 14 Dec 2017 12:07:34 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 0/3] S390-DASD: Fine-tuning for some function
 implementations
References: <4af00744-1c8a-6b33-22c8-d26d569f6c5f@users.sourceforge.net>
 <d7e6649b-cdb4-e686-df0e-472958c94202@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7e6649b-cdb4-e686-df0e-472958c94202@users.sourceforge.net>
Message-Id: <20171214110734.GD4238@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-s390@vger.kernel.org, Jan =?iso-8859-1?Q?H=F6ppner?= <hoeppner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Stefan Haberland <sth@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Dec 14, 2017 at 11:34:01AM +0100, SF Markus Elfring wrote:
> > Date: Wed, 10 May 2017 19:43:21 +0200
> > 
> > A few update suggestions were taken into account
> > from static source code analysis.
> > 
> > Markus Elfring (3):
> >   Adjust buffer output in dasd_hosts_print()
> >   Fix typos in two comment lines
> >   Adjust six checks for null pointers
> > 
> >  drivers/s390/block/dasd_eckd.c | 24 +++++++++++-------------
> >  1 file changed, 11 insertions(+), 13 deletions(-)
> 
> 
> Are there any chances that such change possibilities (and further adjustments)
> will be integrated in this software area?

No.
