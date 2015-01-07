Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 7 Jan 2015 16:36:17 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: [PATCH] s390: include: timex: Use macro CLOCK_STORE_SIZE
 instead of hard code number
Message-ID: <20150107163617.190b5992@mschwide>
In-Reply-To: <54AD4677.6040009@sunrus.com.cn>
References: <54A55954.6000002@sunrus.com.cn>
	<20150102094625.GA4059@osiris>
	<54A76584.6020700@sunrus.com.cn>
	<20150105095948.0612e7bc@mschwide>
	<54AD4677.6040009@sunrus.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Chen Gang S <gang.chen@sunrus.com.cn>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, holzheu@linux.vnet.ibm.com, linux-s390@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, 07 Jan 2015 22:45:11 +0800
Chen Gang S <gang.chen@sunrus.com.cn> wrote:

> On 01/05/2015 04:59 PM, Martin Schwidefsky wrote:
> > On Sat, 03 Jan 2015 11:44:04 +0800
> > Chen Gang <gang.chen@sunrus.com.cn> wrote:
> > 
> >>
> >> Thank you for your work.
> >>
> >> In honest, originally, I was not sure whether it would cause bug (do not
> >> know gcc would generic incorrect code for it). :-)
> > 
> > Even if the code happened to be correct it does not matter. The intention
> > of the sizeof() has been to get to the correct 16, not 8. The fix is
> > fine as it is.
> > 
> 
> Excuse me, my English is not quite well, I am not quite sure about what
> you said (might misunderstand what you said), so I provide the related
> information below for confirmation, please check, thanks.
> 
> sizeof(clk) is for a pointer, not for an array (for C language, it
> treats array parameter as a pointer), the related demo is below:

And your patch fixes this problem. My comment was in regard to the
impact of the original bug. As the typeof construct is used to
prevent the compiler from over-optimizing, the code can come out
correct even if the bug is present.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
