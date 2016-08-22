Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 22 Aug 2016 08:24:09 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390/tape: Use memdup_user() rather than duplicating
 its implementation
In-Reply-To: <6b4cac6d-415c-b1e0-9b40-0344ac6f0351@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
        <6b4cac6d-415c-b1e0-9b40-0344ac6f0351@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20160822082409.3fb79c4e@mschwide>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Julia Lawall <julia.lawall@lip6.fr>
List-ID: <linux-s390.vger.kernel.org>

On Sat, 20 Aug 2016 19:32:03 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 20 Aug 2016 19:25:34 +0200
> 
> Reuse existing functionality from memdup_user() instead of keeping
> duplicate source code.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to linux-s390. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
