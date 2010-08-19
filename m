Return-Path: <linux-arch-owner@vger.kernel.org>
Message-ID: <4C6CB54A.4090605@linux.intel.com>
Date: Wed, 18 Aug 2010 21:38:34 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
MIME-Version: 1.0
Subject: Re: [PATCHv2 2/1] Consolidate CONFIG_DEBUG_STRICT_USER_COPY_CHECKS
References: <201008181428.45029.arnd@arndb.de> <1282184898-30599-1-git-send-email-sboyd@codeaurora.org>
In-Reply-To: <1282184898-30599-1-git-send-email-sboyd@codeaurora.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20100819043834.gAgOceB5z7dRqBcOEtqrzKkeNp9aHhkFFVT0sYCGzeA@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Stephen Boyd <sboyd@codeaurora.org>
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-parisc@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Helge Deller <deller@gmx.de>
List-ID: <linux-s390.vger.kernel.org>

On 8/18/2010 7:28 PM, Stephen Boyd wrote:
> The help text for this config is duplicated across the x86,
> parisc, s390, and arm Kconfig.debug files. Arnd Bergman noted
> that the help text was slightly misleading and should be fixed to
> state that enabling this option isn't a problem when using pre 4.4
> gcc.
>
> To simplify the rewording, consolidate the text into
> lib/Kconfig.debug and modify it there to be more explicit about
> when you should say N to this config.
>    


Acked-by: Arjan van de Ven <arjan@linux.intel.com>
