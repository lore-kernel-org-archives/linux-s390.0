From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [qemu-s390x] [PATCH RFC 2/2] vfio-ccw: support for halt/clear
 subchannel
Date: Mon, 11 Jun 2018 13:12:41 +0200
Message-ID: <20180611131241.06100c12.cohuck@redhat.com>
References: <20180509154822.23510-1-cohuck@redhat.com>
        <20180509154822.23510-3-cohuck@redhat.com>
        <c18f9b9f-da00-1a0b-8ef0-7ac223c73d1a@linux.ibm.com>
        <20180515181006.0cb1dfc2.cohuck@redhat.com>
        <a5d08fb7-d9c1-b230-fe0c-acebbda2ba65@linux.ibm.com>
        <20180522145208.310143ea.cohuck@redhat.com>
        <4e4001cc-540e-0f2b-bbd1-1f82ca594bb3@linux.ibm.com>
        <20180605151449.22aafbfc.cohuck@redhat.com>
        <e73038ff-fb2d-5865-8b84-e775990f3983@linux.ibm.com>
        <20180606142131.74ea2eb7.cohuck@redhat.com>
        <5b77ec9c-41b8-2e32-ce79-d9005b93fdd0@linux.ibm.com>
        <20180607115442.6a779ed9.cohuck@redhat.com>
        <10c8a0ac-fe61-d7c7-c7bb-0fffc6909cb3@linux.ibm.com>
        <20180607183407.1ea5ab89.cohuck@redhat.com>
        <0c1e1b26-0c6a-fdc2-0c1a-2e2d58c2cb73@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0c1e1b26-0c6a-fdc2-0c1a-2e2d58c2cb73@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Halil Pasic <pasic@linux.ibm.com>
Cc: Pierre Morel <pmorel@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Dong Jia Shi <bjsdjshi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Fri, 8 Jun 2018 22:40:39 +0200
Halil Pasic <pasic@linux.ibm.com> wrote:

> Your welcome. The discussion is kind of taking place all over the
> place. I'm actively trying to find the best place to answer, and avoid
> overtalking topics -- but it does not seem to work. Please bear with me.

To help with this discussion (and with vfio-ccw design and development
in general), I've created
https://wiki.qemu.org/ToDo/Channel_I/O_Passthrough to collect some
things. Let me know if any of you folks still needs a wiki account.
