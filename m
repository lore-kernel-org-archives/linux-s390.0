From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 1/1] s390: vfio-ccw: push down unsupported IDA check
Date: Thu, 17 May 2018 11:42:56 +0200
Message-ID: <20180517114256.0ee945c1.cohuck@redhat.com>
References: <20180516173342.15174-1-pasic@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180516173342.15174-1-pasic@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, "Jason J. Herne" <jjherne@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 16 May 2018 19:33:42 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> There is at least one relevant guest OS that doesn't set the IDA flags in
> the ORB as we would like them, but never uses any IDA. So instead of
> saying -EOPNOTSUPP when observing an ORB, such that a channel program
> specified by it could be a not supported one, let us say -EOPNOTSUPP only
> if the channel program is a not supported one.
> 
> Of course, the real solution would be doing proper translation for all
> IDA. This is possible, but given the current code not straight forward.
> 
> Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
> ---
> ---
>  drivers/s390/cio/vfio_ccw_cp.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)

Thanks, applied.
