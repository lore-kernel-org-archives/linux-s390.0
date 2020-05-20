Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 20 May 2020 10:04:59 +0200
From: Valentin =?utf-8?B?VmlkacSH?= <vvidic@valentin-vidic.from.hr>
Subject: Re: [PATCH] s390/sclp_vt220: Fix console name to match device
Message-ID: <20200520080459.GP4974@valentin-vidic.from.hr>
References: <20200519181654.16765-1-vvidic@valentin-vidic.from.hr>
 <65218cdb-d03f-29a8-1e78-42ff2d4f958d@de.ibm.com>
 <20200520070743.GO4974@valentin-vidic.from.hr>
 <cba24059-b3a5-1587-c1f3-8d7dfd0807f5@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cba24059-b3a5-1587-c1f3-8d7dfd0807f5@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org

On Wed, May 20, 2020 at 09:14:23AM +0200, Christian Borntraeger wrote:
> My point was more that a similar issue should happen when installing in LPAR. LPAR
> uses the line mode style console which is ttyS0 for the console but sclp_line0 for the
> tty. How does the debian installer handle this?

I suppose it would fail the same way, but I have no way to verify.

> Regarding your patch I fear that this patch would break existing
> setups so we cannot use it as is.

Right, if some software/documentation depends on the name ttysclp0,
then I guess it is not possible to change any of the two names.

-- 
Valentin
