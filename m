Return-Path: <linux-kernel-owner+w=401wt.eu-S1758701AbYGORSR@vger.kernel.org>
Date: Tue, 15 Jul 2008 19:17:48 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [2.6 patch] chsc headers userspace cleanup
Message-ID: <20080715191748.1f3905ad@gondolin.boeblingen.de.ibm.com>
In-Reply-To: <20080715125817.GB24533@cs181140183.pp.htv.fi>
References: <20080715125817.GB24533@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Adrian Bunk <bunk@kernel.org>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 15 Jul 2008 15:58:18 +0300,
Adrian Bunk <bunk@kernel.org> wrote:

> Kernel headers shouldn't expose functions to userspace.

Could you please elaborate? Especially as I see e.g.
include/linux/virtio_ring.h exporting functions outside #ifdef
__KERNEL__ as well...
