Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:30725 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725870AbgDUPfy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Apr 2020 11:35:54 -0400
Date: Tue, 21 Apr 2020 17:35:44 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v3 0/8] s390x/vfio-ccw: Channel Path Handling [KVM]
Message-ID: <20200421173544.36b48657.cohuck@redhat.com>
In-Reply-To: <20200417023001.65006-1-farman@linux.ibm.com>
References: <20200417023001.65006-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>

On Fri, 17 Apr 2020 04:29:53 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Here is a new pass at the channel-path handling code for vfio-ccw.
> Changes from previous versions are recorded in git notes for each patch.
> 
> I dropped the "Remove inline get_schid()" patch from this version.
> When I made the change suggested in v2, it seemed rather frivolous and
> better to just drop it for the time being.
> 
> I suspect that patches 5 and 7 would be better squashed together, but I
> have not done that here.  For future versions, I guess.

The result also might get a bit large.

> 
> With this, and the corresponding QEMU series (to be posted momentarily),
> applied I am able to configure off/on a CHPID (for example, by issuing
> "chchp -c 0/1 xx" on the host), and the guest is able to see both the
> events and reflect the updated path masks in its structures.

Basically, this looks good to me (modulo my comments).

One thing though that keeps coming up: do we need any kind of
serialization? Can there be any confusion from concurrent reads from
userspace, or are we sure that we always provide consistent data?
