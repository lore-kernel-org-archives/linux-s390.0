From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v8 01/13] update-linux-headers: update for vfio-ccw
Date: Thu, 18 May 2017 15:08:56 +0200
Message-ID: <20170518150856.50c90513.cornelia.huck@de.ibm.com>
References: <20170517004813.58227-1-bjsdjshi@linux.vnet.ibm.com>
        <20170517004813.58227-2-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170517004813.58227-2-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, eric.auger@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Wed, 17 May 2017 02:48:01 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Add vfio_ccw.h.
> 
> Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
> ---
>  scripts/update-linux-headers.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 6a370a8669..2f906c4d16 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -113,7 +113,7 @@ done
> 
>  rm -rf "$output/linux-headers/linux"
>  mkdir -p "$output/linux-headers/linux"
> -for header in kvm.h kvm_para.h vfio.h vhost.h \
> +for header in kvm.h kvm_para.h vfio.h vfio_ccw.h vhost.h \
>                psci.h userfaultfd.h; do
>      cp "$tmpdir/include/linux/$header" "$output/linux-headers/linux"
>  done

I have included this in a complete linux-headers update.
