Return-Path: <SRS0=iEdC=PQ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 8 Jan 2019 09:22:19 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v3 1/8] arch: Use asm-generic/socket.h when possible
References: <20190108032657.8331-1-deepa.kernel@gmail.com>
 <20190108032657.8331-2-deepa.kernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20190108032657.8331-2-deepa.kernel@gmail.com>
Message-Id: <20190108082219.GA7023@osiris>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: davem@davemloft.net, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, chris@zankel.net, fenghua.yu@intel.com, tglx@linutronix.de, schwidefsky@de.ibm.com, linux-ia64@vger.kernel.org, linux-xtensa@linux-xtensa.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 07, 2019 at 07:26:50PM -0800, Deepa Dinamani wrote:
> Many architectures maintain an arch specific copy of the
> file even though there are no differences with the asm-generic
> one. Allow these architectures to use the generic one instead.
> 
> Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
> ---
>  arch/s390/include/uapi/asm/Kbuild     |   1 +
>  arch/s390/include/uapi/asm/socket.h   | 117 ------------------------

For the s390 bits:

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
