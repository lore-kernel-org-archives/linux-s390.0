Return-Path: <linux-kernel-owner+w=401wt.eu-S1756798AbXD0RQ6@vger.kernel.org>
Subject: Re: [patch 18/38] Improved oops output.
References: <20070427140503.087958775@de.ibm.com>
	<20070427140516.013904506@de.ibm.com>
From: Andi Kleen <andi@firstfloor.org>
Date: 27 Apr 2007 20:14:01 +0200
In-Reply-To: <20070427140516.013904506@de.ibm.com>
Message-ID: <p733b2l3ct2.fsf@bingen.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Martin Schwidefsky <schwidefsky@de.ibm.com> writes:

> Second a disassembler is added that decodes the instructions surrounding
> the faulting PSW. 

Is that really needed? I use a simple wrapper around as/objdump for this
and it works great.

(ftp://ftp.firstfloor.org/pub/ak/shell/decodecode) 

-Andi
