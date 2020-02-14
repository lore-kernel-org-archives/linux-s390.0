Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:25613 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727822AbgBNN1Q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 14 Feb 2020 08:27:16 -0500
Date: Fri, 14 Feb 2020 14:27:06 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH v2 9/9] vfio-ccw: Remove inline get_schid() routine
Message-ID: <20200214142706.4d6a1efc.cohuck@redhat.com>
In-Reply-To: <20200206213825.11444-10-farman@linux.ibm.com>
References: <20200206213825.11444-1-farman@linux.ibm.com>
        <20200206213825.11444-10-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Thu,  6 Feb 2020 22:38:25 +0100
Eric Farman <farman@linux.ibm.com> wrote:

> This seems misplaced in the middle of FSM, returning the schid
> field from inside the private struct.  We could move this macro
> into vfio_ccw_private.h, but this doesn't seem to simplify things
> that much.  Let's just remove it, and use the field directly.

It had been introduced with the first set of traces, I'm now wondering
why, as it doesn't do any checking.

> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_fsm.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
