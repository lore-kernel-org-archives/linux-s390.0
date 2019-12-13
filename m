Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:32926 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725799AbfLMJd6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 13 Dec 2019 04:33:58 -0500
Date: Fri, 13 Dec 2019 10:33:46 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v4 7/9] s390x: css: msch, enable test
Message-ID: <20191213103346.1e42d52b.cohuck@redhat.com>
In-Reply-To: <d34fdb07-c2ff-3a1e-eb31-cf9d160ebac9@linux.ibm.com>
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
        <1576079170-7244-8-git-send-email-pmorel@linux.ibm.com>
        <20191212130111.0f75fe7f.cohuck@redhat.com>
        <83d45c31-30c3-36e1-1d68-51b88448f4af@linux.ibm.com>
        <20191212151002.1c7ca4eb.cohuck@redhat.com>
        <c92089cf-39f4-3b64-79a8-3264654130b1@linux.ibm.com>
        <20191212153303.6444697e.cohuck@redhat.com>
        <a29048f4-1783-54c6-8bf3-91d573b2d49d@linux.ibm.com>
        <d34fdb07-c2ff-3a1e-eb31-cf9d160ebac9@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Thu, 12 Dec 2019 18:33:15 +0100
Pierre Morel <pmorel@linux.ibm.com> wrote:

> After all, I make it simple by testing if the MSCH works as expected, no 
> retry, no delay.
> This is just a test.

That's probably fine if you only run under kvm (not sure what your
further plans here are).

> 
> I will add a new patch to add a library function to enable the channel, 
> with retry to serve when we really need to enable the channel, not to test.

A simple enable should be enough for kvm-only usage, we can add a retry
easily if needed.

We probably can also defer adding the library function until after we
get another user :)
