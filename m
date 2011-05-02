Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 2 May 2011 17:01:41 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH resend] s390: oprofile: fix error checks in
 oprofile_hwsampler_init()
Message-ID: <20110502170141.0db73ad9@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <20110502154805.71664123@absol.kitzblitz>
References: <20110502154805.71664123@absol.kitzblitz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Nicolas Kaiser <nikai@nikai.net>
Cc: Robert Richter <robert.richter@amd.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, oprofile-list@lists.sf.net, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2 May 2011 15:48:05 +0200
Nicolas Kaiser <nikai@nikai.net> wrote:

> Checking 'oprofile_min_interval < 0' and
> 'oprofile_max_interval < 0' doesn't work because
> 'oprofile_min_interval' and 'oprofile_max_interval' are unsigned.
> 
> Signed-off-by: Nicolas Kaiser <nikai@nikai.net>

Makes sense, I'll queue it up. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
