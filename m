Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC92C07E96
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 16:45:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7473E60FF4
	for <linux-s390@archiver.kernel.org>; Tue, 13 Jul 2021 16:45:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbhGMQsW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 13 Jul 2021 12:48:22 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52546 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229650AbhGMQsV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 13 Jul 2021 12:48:21 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 16DGX0EH067216;
        Tue, 13 Jul 2021 12:45:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=ojFuSzKKOSr4LKh3/fMZBEKlp89iSGXN4qA9horBTTU=;
 b=AcT+7zNAMBt8CwzIYuEAVgJ5JvvE+6DSZqp+uymJQ1Yo7+8BNkDAgRTNkNRKFAEEYFpE
 1Nf2ibJDOD3la2BFQp07Okljxx8iqZO4QBJmL+tmQJXD9clp4mbWUQvr5FeZa1WAHtrX
 4OBPDn7IBFuVX1nulvGJkt2lfg/QE2ARKdN5My1X4fZogOWasiKW4PwQSXwgdOjHeKQ4
 UgqX5oo95nJJwA+C82d50Afj+VesTWUUwrIB8BYy71imeV4e30vH+3lrqtmEiCLkngJB
 3qBGiQt9NimEeVbrTLU5Xv85HHW9k1R7tnPqGJ5S+BDi0IC89G6cLPa7rjyrO8sNo6Qx PA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qrgmh0rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 12:45:30 -0400
Received: from m0098394.ppops.net (m0098394.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 16DGXTsa068804;
        Tue, 13 Jul 2021 12:45:30 -0400
Received: from ppma01fra.de.ibm.com (46.49.7a9f.ip4.static.sl-reverse.com [159.122.73.70])
        by mx0a-001b2d01.pphosted.com with ESMTP id 39qrgmh0qr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 12:45:29 -0400
Received: from pps.filterd (ppma01fra.de.ibm.com [127.0.0.1])
        by ppma01fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 16DGhICP025997;
        Tue, 13 Jul 2021 16:45:27 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma01fra.de.ibm.com with ESMTP id 39q3688qwt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jul 2021 16:45:27 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 16DGjO3h21561798
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Jul 2021 16:45:24 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6E8DEA4054;
        Tue, 13 Jul 2021 16:45:24 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2DF5DA405F;
        Tue, 13 Jul 2021 16:45:23 +0000 (GMT)
Received: from li-e979b1cc-23ba-11b2-a85c-dfd230f6cf82 (unknown [9.171.74.248])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue, 13 Jul 2021 16:45:23 +0000 (GMT)
Date:   Tue, 13 Jul 2021 18:45:17 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Tony Krowiak <akrowiak@linux.ibm.com>
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        borntraeger@de.ibm.com, cohuck@redhat.com,
        pasic@linux.vnet.ibm.com, jjherne@linux.ibm.com, jgg@nvidia.com,
        alex.williamson@redhat.com, kwankhede@nvidia.com,
        frankja@linux.ibm.com, david@redhat.com, imbrenda@linux.ibm.com,
        hca@linux.ibm.com
Subject: Re: [PATCH] s390/vfio-ap: do not open code locks for
 VFIO_GROUP_NOTIFY_SET_KVM notification
Message-ID: <20210713184517.48eacee6.pasic@linux.ibm.com>
In-Reply-To: <5dd3cc05-f789-21a3-50c7-ee80d850a105@linux.ibm.com>
References: <20210707154156.297139-1-akrowiak@linux.ibm.com>
        <20210713013815.57e8a8cb.pasic@linux.ibm.com>
        <5dd3cc05-f789-21a3-50c7-ee80d850a105@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
Content-Type: text/plain; charset=US-ASCII
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 2k5XHriGKpiQVmQvoJe8dVu3aAEBaFFd
X-Proofpoint-GUID: aJM1J5SmjibhZg3SBp5J0lR_Hdc25gp1
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-07-13_08:2021-07-13,2021-07-13 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 suspectscore=0 mlxscore=0
 malwarescore=0 phishscore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2107130106
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 13 Jul 2021 09:48:01 -0400
Tony Krowiak <akrowiak@linux.ibm.com> wrote:

> On 7/12/21 7:38 PM, Halil Pasic wrote:
> > On Wed,  7 Jul 2021 11:41:56 -0400
> > Tony Krowiak <akrowiak@linux.ibm.com> wrote:
> >  
> >> It was pointed out during an unrelated patch review that locks should not
> >> be open coded - i.e., writing the algorithm of a standard lock in a
> >> function instead of using a lock from the standard library. The setting and
> >> testing of the kvm_busy flag and sleeping on a wait_event is the same thing
> >> a lock does. Whatever potential deadlock was found and reported via the
> >> lockdep splat was not magically removed by going to a wait_queue; it just
> >> removed the lockdep annotations that would identify the issue early  
> > Did you change your opinion since we last talked about it? This reads to
> > me like we are deadlocky without this patch, because of the last
> > sentence.  
> 
> The words are a direct paraphrase of Jason G's responses to my
> query regarding what he meant by open coding locks. I
> am choosing to take his word on the subject and remove the
> open coded locks.
> 
> Having said that, we do not have a deadlock problem without
> this patch. If you recall, the lockdep splat occurred ONLY when
> running a Secure Execution guest in a CI environment. Since
> AP is not yet supported for SE guests, there is no danger of
> a lockdep splat occurring in a customer environment. Given
> Jason's objections to the original solution (i.e., kvm_busy flag
> and wait queue), I decided to replace the so-called open
> coded locks.

I'm in favor of doing that. But if   ("s390/vfio-ap: fix
circular lockdep when setting/clearing crypto masks") ain't buggy,
then this patch does not qualify for stable. For a complete set of
rules consult:
https://github.com/torvalds/linux/blob/master/Documentation/process/stable-kernel-rules.rst

Here the most relevant points:
* It must fix a real bug that bothers people (not a, "This could be a
problem..." type thing).
* t must fix a problem that causes a build error (but not for things
marked CONFIG_BROKEN), an oops, a hang, data corruption, a real security
issue, or some "oh, that's not good" issue. In short, something critical.
* No "theoretical race condition" issues, unless an explanation of how
the race can be exploited is also provided.

Jason may give it another try to convince us that 0cc00c8d4050 only
silenced lockdep, but vfio_ap remained prone to deadlocks. To my best
knowledge using condition variable and a mutex is one of the well known
ways to implement an rwlock. 

In my opinion, you should drop the fixes tag, drop the cc stable, and
provide a patch description that corresponds to *your* understanding
of the situation.

Neither the Fixes tag or the stable process is (IMHO) meant for these
types of (style) issues. And if you don't think the alleged problem is
real, don't make the description of your patch say it is real.

Regards,
Halil

> 
> >
> > Regards,
> > Halil  
> 

