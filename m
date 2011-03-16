From: Rusty Russell <rusty@rustcorp.com.au>
Date: Wed, 16 Mar 2011 03:58:13 +0000
Subject: Re: [PATCH 00/02] virtio: Virtio platform driver
Message-Id: <87d3lriv7e.fsf@rustcorp.com.au>
References: <20110310070541.27327.52089.sendpatchset@t400s>
In-Reply-To: <20110310070541.27327.52089.sendpatchset@t400s>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
List-Archive: <https://lore.kernel.org/linux-sh/>
List-Post: <mailto:linux-sh@vger.kernel.org>
To: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org
Cc: linux-sh@vger.kernel.org, virtualization@lists.linux-foundation.org, mst@redhat.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, 10 Mar 2011 16:05:41 +0900, Magnus Damm <magnus.damm@gmail.com> wrote:
> virtio: Virtio platform driver
> 
> [PATCH 01/02] virtio: Break out lguest virtio code to virtio_lguest.c
> [PATCH 02/02] virtio: Add virtio platform driver

I have no problem with these patches, but it's just churn until we see
your actual drivers.

The S/390 devs might be interested, as their bus is very similar too...

Cheers,
Rusty.
