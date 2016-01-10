From: Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [PATCH v3 3/3] checkpatch: add virt barriers
Date: Mon, 11 Jan 2016 09:13:39 +1100
Message-ID: <CAGRGNgXQANbKD=VA0Qx4Wp1+MpZUVV7by8RrKxF9o=qu=vUQqA@mail.gmail.com>
References: <1452454200-8844-1-git-send-email-mst@redhat.com> <1452454200-8844-4-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-mips-bounce@linux-mips.org>
In-Reply-To: <1452454200-8844-4-git-send-email-mst@redhat.com>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>, Peter Zijlstra <peterz@infradead.org>, Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>, virtualization@lists.linux-foundation.org, Stefano Stabellini <stefano.stabellini@eu.citrix.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, sparclinux <sparclinux@vger.kernel.org>, "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>, linux-metag@vger.kernel.org, linux-mips@linux-mips.org, x86@kernel.org, user-mode-
List-ID: <linux-s390.vger.kernel.org>

Hi Michael,

On Mon, Jan 11, 2016 at 6:31 AM, Michael S. Tsirkin <mst@redhat.com> wrote:
> Add virt_ barriers to list of barriers to check for
> presence of a comment.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  scripts/checkpatch.pl | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 15cfca4..4466579 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -5133,7 +5133,8 @@ sub process {
>                 }x;
>                 my $all_barriers = qr{
>                         $barriers|
> -                       smp_(?:$smp_barrier_stems)
> +                       smp_(?:$smp_barrier_stems)|
> +                       virt_(?:$smp_barrier_stems)

Sorry I'm late to the party here, but would it make sense to write this as:

(?:smp|virt)_(?:$smp_barrier_stems)

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
