From: Gerald Schaefer <gerald.schaefer@de.ibm.com>
Subject: Re: [PATCH v2] arch: s390: appldata: using strncpy() and strnlen()
 instead of sprintf()
Date: Mon, 27 May 2013 18:23:06 +0200
Message-ID: <20130527182306.3bd8a252@thinkpad>
References: <51A2CC07.5010100@asianux.com>
	<CAMuHMdXTW3QOxfAfqQXdbSpP4R83srFf7eMfu5fA-75S_Mujsg@mail.gmail.com>
	<51A32D81.2010105@asianux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-arch-owner@vger.kernel.org>
In-Reply-To: <51A32D81.2010105@asianux.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Chen Gang <gang.chen@asianux.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, Linux-Arch <linux-arch@vger.kernel.org>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 27 May 2013 17:55:13 +0800
Chen Gang <gang.chen@asianux.com> wrote:

> 
> 'buf[2]' is 2 bytes length, and sprintf() will append '\0' at the end
> of string "?\n", so original implementation is memory overflow.
> 
> Need use strncpy() and strnlen() instead of sprintf().
> 
> 
> Signed-off-by: Chen Gang <gang.chen@asianux.com>

Applied, thanks.
