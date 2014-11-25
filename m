Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 25 Nov 2014 18:57:16 +0100
From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: [PATCH v4 16/42] KVM: s390 allow virtio_ccw status writes to
 fail
Message-ID: <20141125185716.0af7e4b0.cornelia.huck@de.ibm.com>
In-Reply-To: <1416933600-21398-17-git-send-email-mst@redhat.com>
References: <1416933600-21398-1-git-send-email-mst@redhat.com>
	<1416933600-21398-17-git-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>, rusty@au1.ibm.com, nab@linux-iscsi.org, pbonzini@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>, linux390@de.ibm.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, 25 Nov 2014 18:42:32 +0200
"Michael S. Tsirkin" <mst@redhat.com> wrote:

missing colon after "s390" in subject

> Gracefully handle failure to write device status.
> We really should handle other errors as well, but this one is needed for
> virtio 1.0 compliance.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>  drivers/s390/kvm/virtio_ccw.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
