Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31394 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728569AbgBJMuy (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 07:50:54 -0500
Date: Mon, 10 Feb 2020 13:50:40 +0100
From: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH/RFC] KVM: s390: protvirt: pass-through rc and rrc
Message-ID: <20200210135040.24f06b8e.cohuck@redhat.com>
In-Reply-To: <a94f3d09-1474-29d2-a2d3-3118170e494e@de.ibm.com>
References: <62d5cd46-93d7-e272-f9bb-d4ec3c7a1f71@de.ibm.com>
        <20200210114526.134769-1-borntraeger@de.ibm.com>
        <a94f3d09-1474-29d2-a2d3-3118170e494e@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: thuth@redhat.com, Ulrich.Weigand@de.ibm.com, aarcange@redhat.com, david@redhat.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com

On Mon, 10 Feb 2020 13:06:19 +0100
Christian Borntraeger <borntraeger@de.ibm.com> wrote:

> What about the following. I will rip out RC and RRC but add 
> a 32bit flags field (which must be 0) and 3*64 bit reserved.

Probably dumb question: How are these new fields supposed to be used?
