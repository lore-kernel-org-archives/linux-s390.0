Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39446 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729351AbfHTTE2 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 20 Aug 2019 15:04:28 -0400
Subject: Re: [kvm-unit-tests PATCH 0/3] s390x: More emulation tests
References: <20190820105550.4991-1-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <09b66729-1263-381f-9af5-9f68332c5415@redhat.com>
Date: Tue, 20 Aug 2019 21:04:26 +0200
MIME-Version: 1.0
In-Reply-To: <20190820105550.4991-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com

On 20.08.19 12:55, Janosch Frank wrote:
> The first patch allows for CECSIM booting via PSW restart.
> The other ones add diag288 and STSI tests.
> 
> I chose to start with these since they are low controversy. My queue
> still contains the sclp patches and a simple smp library with
> tests. They will follow later.

On which branch do these patches apply? I fail to am 2+3 on master (well
I didn't try too hard to resolve ;) ). Do you have a branch somewhere?

-- 

Thanks,

David / dhildenb
