From: Thomas Huth <thuth@redhat.com>
Date: Mon, 19 Feb 2018 19:52:22 +0000
Subject: Re: [PATCH v3 2/3] s390/char : Rename EBCDIC keymap variables
Message-Id: <250077c8-ccef-fbbc-1d53-8a5cc3984243@redhat.com>
References: <cover.1519053920.git.alifm@linux.vnet.ibm.com>
 <4e0d31cf01c9fff5fe177338f14b1ca3f6871fb5.1519053920.git.alifm@linux.vnet.ibm.com>
In-Reply-To: <4e0d31cf01c9fff5fe177338f14b1ca3f6871fb5.1519053920.git.alifm@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-fbdev/>
List-Post: <mailto:linux-fbdev@vger.kernel.org>
To: Farhan Ali <alifm@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc: geert@linux-m68k.org, borntraeger@de.ibm.com, tomi.valkeinen@ti.com, b.zolnierkie@samsung.com
List-ID: <linux-s390.vger.kernel.org>

On 19.02.2018 16:47, Farhan Ali wrote:
> The Linux Virtual Terminal (VT) layer provides a default keymap
> which is compiled when VT layer is enabled. But at the same time
> we are also compiling the EBCDIC keymap and this causes the linker
> to complain.
> 
> So let's rename the EBCDIC keymap variables to prevent linker
> conflict.
> 
> Signed-off-by: Farhan Ali <alifm@linux.vnet.ibm.com>
> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  drivers/s390/char/defkeymap.c | 66 ++++++++++++++++++++++---------------------
>  drivers/s390/char/keyboard.c  | 32 ++++++++++-----------
>  drivers/s390/char/keyboard.h  | 11 ++++++++
>  3 files changed, 61 insertions(+), 48 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>
