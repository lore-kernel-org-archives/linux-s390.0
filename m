Return-Path: <linux-kernel-owner+w=401wt.eu-S1758868AbXJDTJH@vger.kernel.org>
Date: Thu, 4 Oct 2007 21:10:15 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [patch 00/34] s390 patches for 2.6.24
Message-ID: <20071004191015.GA23211@uranus.ravnborg.org>
References: <20071004112706.574737175@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071004112706.574737175@de.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Martin.
On Thu, Oct 04, 2007 at 01:27:06PM +0200, Martin Schwidefsky wrote:
> The current set of s390 patches ready to be pushed once 2.6.23
> has hit the streets.

I noticed that I had not yet beautified the vmlinux.lds file of s390.
Please consider the next two patches for 2.6.24.

The first patch refactor vmlinux.lds to a consistent (and more readable)
style that is being gradually introduced for all archs.
Rationale behind a consistent style is to make across-all-archs
changes less error prone and to better recongnize similar patterns.
The patch moves a few labels so they get the correct value even if
ld decide to align the section a few bytes.

The second patch introduce use of PAGE_SIZE as replacemnt of the
hardcoded value 4096 and convert a few decimal numbers to hex.

	Sam
