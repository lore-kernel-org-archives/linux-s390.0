Return-Path: <linux-kernel-owner+w=401wt.eu-S932901AbYEFTvN@vger.kernel.org>
Date: Tue, 6 May 2008 15:47:58 -0400
From: Rik van Riel <riel@redhat.com>
Subject: Re: [patch 8/8] guest page hinting light
Message-ID: <20080506154758.498b25b2@cuia.bos.redhat.com>
In-Reply-To: <20080506155112.820321745@de.ibm.com>
References: <20080506155027.974409738@de.ibm.com>
	<20080506155112.820321745@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 06 May 2008 17:50:35 +0200
Martin Schwidefsky <schwidefsky@de.ibm.com> wrote:

> From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> 
> Use the existing arch_alloc_page/arch_free_page callbacks to do
> the guest page state transitions between stable and unused.
> 
> Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

Acked-by: Rik van Riel <riel@redhat.com>

-- 
All Rights Reversed
