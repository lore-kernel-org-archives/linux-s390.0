Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:4904 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725951AbgAILg4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 06:36:56 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009BWudp073696
        for <linux-s390@vger.kernel.org>; Thu, 9 Jan 2020 06:36:55 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xe0huf1j6-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 09 Jan 2020 06:36:55 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <imbrenda@linux.ibm.com>;
        Thu, 9 Jan 2020 11:36:52 -0000
Date: Thu, 9 Jan 2020 12:36:46 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [kvm-unit-tests PATCH v5 3/4] s390x: lib: add SPX and STPX
 instruction wrapper
In-Reply-To: <ff1041f2-0262-ed89-4c5e-386f69d21cd0@redhat.com>
References: <20200108161317.268928-1-imbrenda@linux.ibm.com>
        <20200108161317.268928-4-imbrenda@linux.ibm.com>
        <ff1041f2-0262-ed89-4c5e-386f69d21cd0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20200109123646.6b79194e@p-imbrenda>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Thomas Huth <thuth@redhat.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com, frankja@linux.ibm.com

On Wed, 8 Jan 2020 19:58:27 +0100
Thomas Huth <thuth@redhat.com> wrote:

> On 08/01/2020 17.13, Claudio Imbrenda wrote:
> > Add a wrapper for the SET PREFIX and STORE PREFIX instructions, and
> > use it instead of using inline assembly everywhere.  
> 
> Either some hunks are missing in this patch, or you should update the
> patch description and remove the second part of the sentence ? ... at
> least I did not spot the changes where you "use it instead of using
> inline assembly everywhere".


oops sorry, the description is a little misleading. I meant
everywhere in the specific unit test, not everywhere in the whole
source tree. 

I should either change the description or actually patch the remaining
users of inline assembly to use the wrappers instead. (any preference?)
