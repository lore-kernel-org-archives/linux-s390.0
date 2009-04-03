Return-Path: <linux-kernel-owner+w=401wt.eu-S1751507AbZDCPqR@vger.kernel.org>
Date: Fri, 3 Apr 2009 17:39:41 +0200
From: Bastian Blank <waldi@debian.org>
Subject: [RFC][PATCH 0/5] Add and use libgcc
Message-ID: <20090403153941.GA7045@wavehammer.waldi.eu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi

gcc always expects to be able to use the symbols in libgcc for
operations that are unsupported on the CPU.  Linux added functions if
needed or just worked around such operations.  Sometimes it even
describes the compiler as broken, even if it is properly documented by
gcc themself.

This patchset adds a copy of libgcc to the kernel and uses it if to do
such unsupported operations.  This way we can remove the usage of
workarounds like do_div.

Unsolved problems:
- It currently uses the gcc-included longlong division support which is marked
  as possibly trapping.
- The libgcc sources are currently unmodifed copies from gcc, this means
  it needs some headers with fixed names.

Bastian

-- 
Leave bigotry in your quarters; there's no room for it on the bridge.
		-- Kirk, "Balance of Terror", stardate 1709.2
