From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] vfio-ccw: process ssch with interrupts disabled
Date: Thu, 19 Apr 2018 11:16:05 +0200
Message-ID: <20180419111605.31354176.cohuck@redhat.com>
References: <20180413140509.9042-1-cohuck@redhat.com>
        <20180418082931.GO5428@bjsdjshi@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180418082931.GO5428@bjsdjshi@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 18 Apr 2018 16:29:31 +0800
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> * Cornelia Huck <cohuck@redhat.com> [2018-04-13 16:05:09 +0200]:
> 
> Nitpick for the title:
> vfio-ccw: process ssch with interrupts disabled
> 
> Should be "vfio: ccw:"?

Yes, that seems to be the more common title.

I've added a cc:stable as well (as the current trend seems to be to
rather add more to stable than less) and pushed out. Unless there are
complaints, I'll send a pull req tomorrow.
