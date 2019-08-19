Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 19 Aug 2019 20:56:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2] s390: vfio-ap: remove unnecessary calls to disable
 queue interrupts
Message-ID: <20190819205632.54fe2844.cohuck@redhat.com>
In-Reply-To: <1566236929-18995-1-git-send-email-akrowiak@linux.ibm.com>
References: <1566236929-18995-1-git-send-email-akrowiak@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, freude@de.ibm.com, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, frankja@linux.ibm.com, jjherne@linux.ibm.com

On Mon, 19 Aug 2019 13:48:49 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> When an AP queue is reset (zeroized), interrupts are disabled. The queue
> reset function currently tries to disable interrupts unnecessarily. This patch
> removes the unnecessary calls to disable interrupts after queue reset.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 21 +++++++++++++++++----
>  1 file changed, 17 insertions(+), 4 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>
