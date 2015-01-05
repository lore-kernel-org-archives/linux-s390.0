Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 5 Jan 2015 09:59:48 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: include: timex: Use macro CLOCK_STORE_SIZE
 instead of hard code number
Message-ID: <20150105095948.0612e7bc@mschwide>
In-Reply-To: <54A76584.6020700@sunrus.com.cn>
References: <54A55954.6000002@sunrus.com.cn>
	<20150102094625.GA4059@osiris>
	<54A76584.6020700@sunrus.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Chen Gang <gang.chen@sunrus.com.cn>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, holzheu@linux.vnet.ibm.com, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sat, 03 Jan 2015 11:44:04 +0800
Chen Gang <gang.chen@sunrus.com.cn> wrote:

> 
> Thank you for your work.
> 
> In honest, originally, I was not sure whether it would cause bug (do not
> know gcc would generic incorrect code for it). :-)

Even if the code happened to be correct it does not matter. The intention
of the sizeof() has been to get to the correct 16, not 8. The fix is
fine as it is.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
