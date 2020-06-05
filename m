Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56399 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726144AbgFEJAf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 5 Jun 2020 05:00:35 -0400
Date: Fri, 5 Jun 2020 11:00:25 +0200
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v7 09/12] s390x: css: msch, enable test
Message-ID: <20200605110025.4a360fe6.cohuck@redhat.com>
In-Reply-To: <3aaa9a99-6958-062d-14a7-fcf8d447ad19@linux.ibm.com>
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
        <1589818051-20549-10-git-send-email-pmorel@linux.ibm.com>
        <20200527114239.65fa9473.cohuck@redhat.com>
        <65501204-f6f3-7800-e382-63ccad77ca38@linux.ibm.com>
        <20200604152945.4cb433bd.cohuck@redhat.com>
        <ea12784c-df16-db4b-dd9c-b5b77bcbe9f9@linux.ibm.com>
        <3aaa9a99-6958-062d-14a7-fcf8d447ad19@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, thuth@redhat.com

On Fri, 5 Jun 2020 10:24:56 +0200
Pierre Morel <pmorel@linux.ibm.com> wrote:

> Hi Connie,
> 
> for the next series, I will move more code of the css.c to the css_lib.c 
> to be able to reuse it for other tests.
> One of your suggestions IIRC.
> So I will not be able to keep your RB until you have a look at the changes.
> I will keep the same algorithms but still...

np, I'll look at it again.
