Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] s390/virtio: remove the old KVM virtio headers
References: <1511500846-24696-1-git-send-email-mst@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <43d45d46-6f76-bb17-cbe4-85ee46b64fab@redhat.com>
Date: Fri, 24 Nov 2017 06:29:37 +0100
MIME-Version: 1.0
In-Reply-To: <1511500846-24696-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 24.11.2017 06:21, Michael S. Tsirkin wrote:
> commit 7fb2b2d51 ("s390/virtio: remove the old KVM virtio transport")
> dropped the transport support. We don't need to keep the header around.
> 
> Cc: Thomas Huth <thuth@redhat.com>
> Cc: Cornelia Huck <cohuck@redhat.com>
> Cc: Halil Pasic <pasic@linux.vnet.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  arch/s390/include/uapi/asm/kvm_virtio.h | 65 ---------------------------------
>  1 file changed, 65 deletions(-)
>  delete mode 100644 arch/s390/include/uapi/asm/kvm_virtio.h
> 
> diff --git a/arch/s390/include/uapi/asm/kvm_virtio.h b/arch/s390/include/uapi/asm/kvm_virtio.h
> deleted file mode 100644
> index 7328367..0000000
> --- a/arch/s390/include/uapi/asm/kvm_virtio.h
> +++ /dev/null

This seems to be already upstream? See:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a401917bc3e2d251ce521

 Thomas
