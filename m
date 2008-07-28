Return-Path: <linux-kernel-owner+w=401wt.eu-S1755823AbYG1SN1@vger.kernel.org>
Subject: Re: [patch 01/15] kmsg: Kernel message catalog macros.
From: Joe Perches <joe@perches.com>
In-Reply-To: <20080728175511.023246676@de.ibm.com>
References: <20080728175355.734299984@de.ibm.com>
	 <20080728175511.023246676@de.ibm.com>
Content-Type: text/plain
Date: Mon, 28 Jul 2008 11:12:04 -0700
Message-Id: <1217268724.9355.14.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, Michael Holzheu <holzheu@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2008-07-28 at 19:53 +0200, Martin Schwidefsky wrote:
> The kmsg component name is defined per source file with the KMSG_COMPONENT
> macro.

Why not use KBUILD_MODNAME?
