From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH RFC 1/2] vfio-ccw: forward halt/clear to device if
 supported
Date: Wed, 16 May 2018 17:52:43 +0200
Message-ID: <20180516175243.2ec79883.cohuck@redhat.com>
References: <20180509154910.23578-1-cohuck@redhat.com>
        <20180509154910.23578-2-cohuck@redhat.com>
        <d2030a0c-6ab6-a470-f7d7-0926a7ff2b28@linux.ibm.com>
        <20180515180104.646cba0c.cohuck@redhat.com>
        <57a7b9b1-130a-3c78-6e29-226f544c69c9@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <57a7b9b1-130a-3c78-6e29-226f544c69c9@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-s390x@nongnu.org, qemu-devel@nongnu.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 16 May 2018 15:53:48 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> On 15/05/2018 18:01, Cornelia Huck wrote:
> > On Fri, 11 May 2018 11:53:52 +0200
> > Pierre Morel <pmorel@linux.ibm.com> wrote:

> >> Couldn't we introduce ABI versioning ?  
> > Can you elaborate what you're referring to?
> >
> > If you mean checking capabilities of the kernel or so: If we can avoid
> > that and just try (and stop if it does not work), I'd prefer that (no
> > dependencies).  
> 
> VFIO_CHECK_EXTENSION is already used in different drivers
> for this kind of interface extension.
> We could use it to setup appropriate callbacks for scsh/csch/xsch/hsch
> depending on the extension argument.

Hm, this might be useful for things like xsch that aren't really well
served by the current interface. Or we could try using the
device-specific capability interface.

Let me think and play with this a bit.
