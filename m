Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:44440 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726091AbgEHLAN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 May 2020 07:00:13 -0400
Date: Fri, 8 May 2020 12:59:58 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] vfio-ccw: document possible errors
Message-ID: <20200508125958.3c0d3ee5.cohuck@redhat.com>
In-Reply-To: <20200407111605.1795-1-cohuck@redhat.com>
References: <20200407111605.1795-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org

On Tue,  7 Apr 2020 13:16:05 +0200
Cornelia Huck <cohuck@redhat.com> wrote:

> Interacting with the I/O and the async regions can yield a number
> of errors, which had been undocumented so far. These are part of
> the api, so remedy that.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  Documentation/s390/vfio-ccw.rst | 54 ++++++++++++++++++++++++++++++++-
>  1 file changed, 53 insertions(+), 1 deletion(-)

Queued with the mentioned minor changes.
