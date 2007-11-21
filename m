Return-Path: <linux-kernel-owner+w=401wt.eu-S1757515AbXKUGFg@vger.kernel.org>
Date: Tue, 20 Nov 2007 22:04:55 -0800
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-rc3-mm1 - Build Failure on S390x
Message-Id: <20071120220455.d73c57e8.akpm@linux-foundation.org>
In-Reply-To: <4743C8A3.60909@linux.vnet.ibm.com>
References: <20071120204525.ff27ac98.akpm@linux-foundation.org>
	<4743C8A3.60909@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux390@de.ibm.com, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, Andy Whitcroft <apw@shadowen.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 21 Nov 2007 11:26:51 +0530 Kamalesh Babulal <kamalesh@linux.vnet.ibm.com> wrote:

> The kernel build fails on S390x, with

Yes, sorry, I forgot to mention that.  I got a large patch reject
between Greg's driver tree and the s390 tree and I couldn't be bothered
fixing it.  s390 is busted in 2.6.24-rc3-mm1.
