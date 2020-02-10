Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:56341 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726950AbgBJM3Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 10 Feb 2020 07:29:24 -0500
Subject: Re: [PATCH/RFC] KVM: s390: protvirt: pass-through rc and rrc
References: <62d5cd46-93d7-e272-f9bb-d4ec3c7a1f71@de.ibm.com>
 <20200210114526.134769-1-borntraeger@de.ibm.com>
 <a94f3d09-1474-29d2-a2d3-3118170e494e@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b43e16d0-6a1c-3898-fadf-794c1e6a0044@redhat.com>
Date: Mon, 10 Feb 2020 13:29:08 +0100
MIME-Version: 1.0
In-Reply-To: <a94f3d09-1474-29d2-a2d3-3118170e494e@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Ulrich.Weigand@de.ibm.com, aarcange@redhat.com, cohuck@redhat.com, david@redhat.com, frankja@linux.ibm.com, frankja@linux.vnet.ibm.com, gor@linux.ibm.com, imbrenda@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org, mimu@linux.ibm.com

On 10/02/2020 13.06, Christian Borntraeger wrote:
> What about the following. I will rip out RC and RRC but add 
> a 32bit flags field (which must be 0) and 3*64 bit reserved.

Flags and reserved always sounds good :-)

 Thomas
