Return-Path: <linux-kernel-owner+w=401wt.eu-S1761387AbXFQWyR@vger.kernel.org>
Subject: Re: [patch] use __asm__ and __volatile__ in i386/arm/s390
	byteorder.h
From: Arjan van de Ven <arjan@infradead.org>
In-Reply-To: <200706171833.29046.vapier@gentoo.org>
References: <200706171833.29046.vapier@gentoo.org>
Content-Type: text/plain
Date: Sun, 17 Jun 2007 15:51:13 -0700
Message-Id: <1182120674.22999.4.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Mike Frysinger <vapier@gentoo.org>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, rmk@arm.linux.org.uk
List-ID: <linux-s390.vger.kernel.org>

On Sun, 2007-06-17 at 18:33 -0400, Mike Frysinger wrote:
> This changes asm() to __asm__() and volatile to __volatile__ so that these
> headers can be used with gcc's -std=c99.

hmm but the kernel doesn't use -std=c99...
