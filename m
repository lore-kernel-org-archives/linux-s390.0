From: Chen Gang <gang.chen@asianux.com>
Subject: Re: [PATCH v2] arch: s390: appldata: using strncpy() and strnlen()
 instead of sprintf()
Date: Tue, 28 May 2013 12:58:14 +0800
Message-ID: <51A43966.7080309@asianux.com>
References: <51A2CC07.5010100@asianux.com> <CAMuHMdXTW3QOxfAfqQXdbSpP4R83srFf7eMfu5fA-75S_Mujsg@mail.gmail.com> <51A32D81.2010105@asianux.com> <20130527182306.3bd8a252@thinkpad>
Mime-Version: 1.0
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <20130527182306.3bd8a252@thinkpad>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On 05/28/2013 12:23 AM, Gerald Schaefer wrote:
> On Mon, 27 May 2013 17:55:13 +0800
> Chen Gang <gang.chen@asianux.com> wrote:
> 
>> > 
>> > 'buf[2]' is 2 bytes length, and sprintf() will append '\0' at the end
>> > of string "?\n", so original implementation is memory overflow.
>> > 
>> > Need use strncpy() and strnlen() instead of sprintf().
>> > 
>> > 
>> > Signed-off-by: Chen Gang <gang.chen@asianux.com>
> Applied, thanks.
> 

Thank you, too.

-- 
Chen Gang

Asianux Corporation
