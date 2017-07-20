From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 0/1] vfio: ccw: bugfix
Date: Thu, 20 Jul 2017 11:07:38 +0200
Message-ID: <20170720110738.2b2c9cb7@gondolin>
References: <20170720031950.64438-1-bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170720031950.64438-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, borntraeger@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On Thu, 20 Jul 2017 05:19:49 +0200
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Hi Conny,
> 
> I got a vfio-ccw bugfix on the kernel from Jason. The patch looks good to me.
> 
> BTW, is it fine with you to let the author sending the patch to you directly,
> or you prefer we queuing a batch of fixes on our devel branch and send them to
> you together periodically (say, target on a certain release)?

You basically can send patches to me at any time, and I'll do a pullreq
when I think it makes sense. I'll take good patches from everyone :)

If you have an urgent bugfix and I'm not available, feel free to have
Martin pick it up directly (with me on cc:).

> 
> Regards!
> 
> Jason J. Herne (1):
>   vfio: ccw: fix bad ptr math for TIC cda translation
> 
>  drivers/s390/cio/vfio_ccw_cp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
