Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731638AbfJONz6 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 15 Oct 2019 09:55:58 -0400
Date: Tue, 15 Oct 2019 15:55:55 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [RFC PATCH 4/4] vfio-ccw: Rename the io_fctl trace
Message-ID: <20191015155555.24275800.cohuck@redhat.com>
In-Reply-To: <20191014180855.19400-5-farman@linux.ibm.com>
References: <20191014180855.19400-1-farman@linux.ibm.com>
        <20191014180855.19400-5-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>
Cc: Halil Pasic <pasic@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>, Jared Rossi <jrossi@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Mon, 14 Oct 2019 20:08:55 +0200
Eric Farman <farman@linux.ibm.com> wrote:

> Rename this trace to the function name, so we remember what is being
> traced instead of an abstract reference to the function control bit
> of the SCSW (since that exists in the IRB, but not the ORB).
> 
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_fsm.c   | 4 ++--
>  drivers/s390/cio/vfio_ccw_trace.c | 2 +-
>  drivers/s390/cio/vfio_ccw_trace.h | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)

That makes sense (I don't supposed this is used in any tooling, as it
is more of a low-level debug trace.)
