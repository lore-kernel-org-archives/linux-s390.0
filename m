Return-Path: <linux-kernel-owner+w=401wt.eu-S1754046AbXDWQx7@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 0/9] Kconfig: cleanup s390 v2.
Date: Mon, 23 Apr 2007 18:52:32 +0200
References: <20070423141123.GA21174@skybase>
In-Reply-To: <20070423141123.GA21174@skybase>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200704231852.33599.arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, akpm@linux-foundation.org, mb@bu3sch.de, linville@tuxdriver.com, maxextreme@gmail.com, gregkh@suse.de
List-ID: <linux-s390.vger.kernel.org>

On Monday 23 April 2007, Martin Schwidefsky wrote:
> I've added the results of the review to the Kconfig cleanup patches
> for s390. Patch #2 has been split, one half has all the HAS_IOMEM
> depends lines the other the remaining !S390 depends lines.
> 

They all look good to me now
