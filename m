Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 10 May 2017 22:28:57 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [PATCH 1/3] s390/dasd: Adjust buffer output in dasd_hosts_print()
Message-ID: <20170510192857.o5cyi4xx2xdo66d7@mwanda>
References: <4af00744-1c8a-6b33-22c8-d26d569f6c5f@users.sourceforge.net>
 <deb83447-9b77-d297-135c-a8af8055b3af@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <deb83447-9b77-d297-135c-a8af8055b3af@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan =?iso-8859-1?Q?H=F6ppner?= <hoeppner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Stefan Haberland <sth@linux.vnet.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, May 10, 2017 at 08:01:17PM +0200, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Wed, 10 May 2017 18:52:28 +0200
> 
> * Use a special format string specification for the desired output of the
>   array "pgid" into a sequence.
> 
>   This issue was detected by using the Coccinelle software.
> 
> * Delete the local variable "j" and a call of the function "seq_puts"
>   wich became unnecessary with this refactoring.
> 
> Fixes: 5a3b7b112884f80ff19b18028fabeb4f9c035518 ("s390/dasd: add query host access to volume support")

Stop using the fixes tag when you are not fixing bugs.

regards,
dan carpenter
