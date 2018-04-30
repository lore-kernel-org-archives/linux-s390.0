From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH 01/10] vfio: ccw: Moving state change out of IRQ context
Date: Mon, 30 Apr 2018 15:56:16 +0200
Message-ID: <20180430155616.38529d08.cohuck@redhat.com>
References: <1524149293-12658-1-git-send-email-pmorel@linux.vnet.ibm.com>
        <1524149293-12658-2-git-send-email-pmorel@linux.vnet.ibm.com>
        <20180424065442.GV12194@bjsdjshi@linux.vnet.ibm.com>
        <ac4b7441-2d17-922b-695e-98c01d87cd42@linux.vnet.ibm.com>
        <20180424115929.5b5e1ff0.cohuck@redhat.com>
        <245ee547-75bc-95f5-5acb-bfa96f91afd2@linux.ibm.com>
        <20180425085726.3a8a97a5.cohuck@redhat.com>
        <bf8256f2-17a4-e1ec-ec35-a10bde734b65@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <bf8256f2-17a4-e1ec-ec35-a10bde734b65@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, pasic@linux.vnet.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Wed, 25 Apr 2018 13:06:31 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> On 04/25/2018 08:57 AM, Cornelia Huck wrote:
> >> AFAIU this will be the problem of the person implementing the clear
> >> and the halt for vfio-ccw. I.e. it's a non-problem right now.  
> > Well, that person is me:)  I will post some RFC Real Soon Now if I stop
> > getting sidetracked...
> >   
> 
> Makes sense. It should be fine either way AFAIU.
> 
> CSCH, more precisely the clear function is supposed to clear the
> interruption request(s) too. But I guess there is no way of the CP to
> identify an I/O interrupt that should have been cleared -- that is catch
> us disrespecting the architecture. I can't think of a way to establish
> must happen before relationship...
> 
> But discarding the first interrupt and delivering just one for the CSCH
> is fine too for the same reason.

Yes, both work. The calling code in the guest has to be able to handle
both anyway, since both can happen on real hardware as well (with a
smaller race window).
