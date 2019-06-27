Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:10272 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726465AbfF0OPC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 27 Jun 2019 10:15:02 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x5RE9PPa009765
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 10:15:01 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tcx4xmx4m-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 27 Jun 2019 10:15:01 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <sth@linux.ibm.com>;
        Thu, 27 Jun 2019 15:14:58 +0100
References: <20190626100658.GB3242@mwanda>
From: Stefan Haberland <sth@linux.ibm.com>
Subject: Re: [PATCH] s390/dasd: Fix a precision vs width bug in
 dasd_feature_list()
Date: Thu, 27 Jun 2019 16:14:54 +0200
MIME-Version: 1.0
In-Reply-To: <20190626100658.GB3242@mwanda>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Message-Id: <7b33439f-6f70-74de-0861-91081e6e048d@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: Jan Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, kernel-janitors@vger.kernel.org

On 26.06.19 12:06, Dan Carpenter wrote:
> The "len" variable is the length of the option up to the next option or
> to the end of the string which ever first.  We want to print the invalid
> option so we want precision "%.*s" but the format is width "%*s" so it
> prints up to the end of the string.
>
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
> Not tested.

Thanks for the patch. I tested it and it works as expected.
Will integrate it through the s390 tree.
