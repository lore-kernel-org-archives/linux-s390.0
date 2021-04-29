Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 870CDC4360C
	for <linux-s390@archiver.kernel.org>; Thu, 29 Apr 2021 20:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6019961441
	for <linux-s390@archiver.kernel.org>; Thu, 29 Apr 2021 20:37:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236920AbhD2Uih (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 29 Apr 2021 16:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237037AbhD2Uif (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 29 Apr 2021 16:38:35 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1845AC06138B
        for <linux-s390@vger.kernel.org>; Thu, 29 Apr 2021 13:37:49 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id t6-20020a170902a5c6b02900e8dfb1a5d7so29419357plq.3
        for <linux-s390@vger.kernel.org>; Thu, 29 Apr 2021 13:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=OjXwyKCntSIP6XJLWOIYPXebRZZc88yCv+0KIud1fF8=;
        b=uDbiePfTM0igD5p0EZIpbSF0uZwk2xXNzOGoPzD6Qyf2A/TELrx9Oo0Bd1IkxnU3PY
         IxLbPtiD+i4u6Og7UqwXH9oSQZX0jYZLvt5Hv3kfs7wyATxO/PlX5hCI3N9pHRSeJZW6
         YwhRaY43tIHRnUGDSRZy3PBkL6ICEsvXnOMrHju6Xnq76GE0GiXl2JuoPohiw2wLo2Aw
         2XPJVT27jgONv4ly1JmCtrF9pLlEsx4pfzM8POHvC12yXLzM0mF1d/6W1T7/ZcGRAUnU
         72mWZoY66O1b8O2fWwNyX4HtPPOG53deUAJns9796s2pEbWsaWo2oX2ekuVUs+sJxaYm
         HCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=OjXwyKCntSIP6XJLWOIYPXebRZZc88yCv+0KIud1fF8=;
        b=tH74b7B2TSFCqQ5CsXmy3S9aH3myq9G5XgdmeGF2r2cGepkufURSsUjWTjEhdOiIao
         LiCReQuSsNdw9A77+/RNklzgYo6TQk5SHwGu+a76BSZbvmRzUwC2fglXFwV9/w3qwOoc
         T+QUkNsGKAB+FPhf+PlPpZfrOv5vOlnkDH40JroH5CmD3jZ+x8NFiKu8d39rlN7tIuK4
         emfLYoKuOHvPjLPOQUd6bEyD6eYEJP0En+wr5iIeDQrSUX/B5y32tL2vSyPLDweCMHg0
         gsQEgKvyJRbvxTgASlMsOeQI8Dgr7GgDMQkaWCY1Z/JFJADtF1PwwcQPfUS0W/3qZHRo
         Gf+g==
X-Gm-Message-State: AOAM533E8zCWq508IsvDRgOya23zWbgBXnLjBhud/4oFSBp2vT4xekfb
        8s2pl6AaoOqSsEVEWRvSsZGyE2Kmk/YdjoR/vw==
X-Google-Smtp-Source: ABdhPJxZioeNsrO3bSksWA1QgQP6cIGfi5dqIAooTrIwpEGefTE8RQ3iykKHw9gyhy6SEJ+5FWdLOuzm9sw39PJm4A==
X-Received: from jgzg.c.googlers.com ([fda3:e722:ac3:10:7f:e700:c0a8:1acf])
 (user=jingzhangos job=sendgmr) by 2002:a17:902:8344:b029:ed:4a5a:1953 with
 SMTP id z4-20020a1709028344b02900ed4a5a1953mr1514596pln.68.1619728668575;
 Thu, 29 Apr 2021 13:37:48 -0700 (PDT)
Date:   Thu, 29 Apr 2021 20:37:39 +0000
In-Reply-To: <20210429203740.1935629-1-jingzhangos@google.com>
Message-Id: <20210429203740.1935629-4-jingzhangos@google.com>
Mime-Version: 1.0
References: <20210429203740.1935629-1-jingzhangos@google.com>
X-Mailer: git-send-email 2.31.1.527.g47e6f16901-goog
Subject: [PATCH v4 3/4] KVM: stats: Add documentation for statistics data
 binary interface
From:   Jing Zhang <jingzhangos@google.com>
To:     KVM <kvm@vger.kernel.org>, KVMARM <kvmarm@lists.cs.columbia.edu>,
        LinuxMIPS <linux-mips@vger.kernel.org>,
        KVMPPC <kvm-ppc@vger.kernel.org>,
        LinuxS390 <linux-s390@vger.kernel.org>,
        Linuxkselftest <linux-kselftest@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Paul Mackerras <paulus@ozlabs.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Sean Christopherson <seanjc@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Peter Shier <pshier@google.com>,
        Oliver Upton <oupton@google.com>,
        David Rientjes <rientjes@google.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     Jing Zhang <jingzhangos@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Signed-off-by: Jing Zhang <jingzhangos@google.com>
---
 Documentation/virt/kvm/api.rst | 171 +++++++++++++++++++++++++++++++++
 1 file changed, 171 insertions(+)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 6cb940b8db50..2d21c70ecb53 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -5034,6 +5034,169 @@ see KVM_XEN_VCPU_SET_ATTR above.
 The KVM_XEN_VCPU_ATTR_TYPE_RUNSTATE_ADJUST type may not be used
 with the KVM_XEN_VCPU_GET_ATTR ioctl.
 
+4.130 KVM_STATS_GETFD
+---------------------
+
+:Capability: KVM_CAP_STATS_BINARY_FD
+:Architectures: all
+:Type: vm ioctl, vcpu ioctl
+:Parameters: none
+:Returns: statistics file descriptor on success, < 0 on error
+
+Errors:
+
+  ======     ======================================================
+  ENOMEM     if the fd could not be created due to lack of memory
+  EMFILE     if the number of opened files exceeds the limit
+  ======     ======================================================
+
+The file descriptor can be used to read VM/vCPU statistics data in binary
+format. The file data is organized into three blocks as below:
++-------------+
+|   Header    |
++-------------+
+| Descriptors |
++-------------+
+| Stats Data  |
++-------------+
+
+The Header block is always at the start of the file. It is only needed to be
+read one time after a system boot.
+It is in the form of ``struct kvm_stats_header`` as below::
+
+	#define KVM_STATS_ID_MAXLEN		64
+
+	struct kvm_stats_header {
+		char id[KVM_STATS_ID_MAXLEN];
+		__u32 name_size;
+		__u32 count;
+		__u32 desc_offset;
+		__u32 data_offset;
+	};
+
+The ``id`` field is identification for the corresponding KVM statistics. For
+KVM statistics, it is in the form of "kvm-{kvm pid}", like "kvm-12345". For
+VCPU statistics, it is in the form of "kvm-{kvm pid}/vcpu-{vcpu id}", like
+"kvm-12345/vcpu-12".
+
+The ``name_size`` field is the size (byte) of the statistics name string
+(including trailing '\0') appended to the end of every statistics descriptor.
+
+The ``count`` field is the number of statistics.
+
+The ``desc_offset`` field is the offset of the Descriptors block from the start
+of the file indicated by the file descriptor.
+
+The ``data_offset`` field is the offset of the Stats Data block from the start
+of the file indicated by the file descriptor.
+
+The Descriptors block is only needed to be read once after a system boot. It is
+an array of ``struct kvm_stats_desc`` as below::
+
+	#define KVM_STATS_TYPE_SHIFT		0
+	#define KVM_STATS_TYPE_MASK		(0xF << KVM_STATS_TYPE_SHIFT)
+	#define KVM_STATS_TYPE_CUMULATIVE	(0x0 << KVM_STATS_TYPE_SHIFT)
+	#define KVM_STATS_TYPE_INSTANT		(0x1 << KVM_STATS_TYPE_SHIFT)
+	#define KVM_STATS_TYPE_MAX		KVM_STATS_TYPE_INSTANT
+
+	#define KVM_STATS_UNIT_SHIFT		4
+	#define KVM_STATS_UNIT_MASK		(0xF << KVM_STATS_UNIT_SHIFT)
+	#define KVM_STATS_UNIT_NONE		(0x0 << KVM_STATS_UNIT_SHIFT)
+	#define KVM_STATS_UNIT_BYTES		(0x1 << KVM_STATS_UNIT_SHIFT)
+	#define KVM_STATS_UNIT_SECONDS		(0x2 << KVM_STATS_UNIT_SHIFT)
+	#define KVM_STATS_UNIT_CYCLES		(0x3 << KVM_STATS_UNIT_SHIFT)
+	#define KVM_STATS_UNIT_MAX		KVM_STATS_UNIT_CYCLES
+
+	#define KVM_STATS_SCALE_SHIFT		8
+	#define KVM_STATS_SCALE_MASK		(0xF << KVM_STATS_SCALE_SHIFT)
+	#define KVM_STATS_SCALE_POW10		(0x0 << KVM_STATS_SCALE_SHIFT)
+	#define KVM_STATS_SCALE_POW2		(0x1 << KVM_STATS_SCALE_SHIFT)
+	#define KVM_STATS_SCALE_MAX		KVM_STATS_SCALE_POW2
+
+	struct kvm_stats_desc {
+		__u32 flags;
+		__s16 exponent;
+		__u16 size;
+		__u32 unused1;
+		__u32 unused2;
+		__u8 name[0];
+	};
+
+The ``flags`` field contains the type and unit of the statistics data described
+by this descriptor. The following flags are supported:
+  * ``KVM_STATS_TYPE_CUMULATIVE``
+    The statistics data is cumulative. The value of data can only be increased.
+    Most of the counters used in KVM are of this type.
+    The corresponding ``count`` filed for this type is always 1.
+  * ``KVM_STATS_TYPE_INSTANT``
+    The statistics data is instantaneous. Its value can be increased or
+    decreased. This type is usually used as a measurement of some resources,
+    like the number of dirty pages, the number of large pages, etc.
+    The corresponding ``count`` field for this type is always 1.
+  * ``KVM_STATS_UNIT_NONE``
+    There is no unit for the value of statistics data. This usually means that
+    the value is a simple counter of an event.
+  * ``KVM_STATS_UNIT_BYTES``
+    It indicates that the statistics data is used to measure memory size, in the
+    unit of Byte, KiByte, MiByte, GiByte, etc. The unit of the data is
+    determined by the ``exponent`` field in the descriptor. The
+    ``KVM_STATS_SCALE_POW2`` flag is valid in this case. The unit of the data is
+    determined by ``pow(2, exponent)``. For example, if value is 10,
+    ``exponent`` is 20, which means the unit of statistics data is MiByte, we
+    can get the statistics data in the unit of Byte by
+    ``value * pow(2, exponent) = 10 * pow(2, 20) = 10 MiByte`` which is
+    10 * 1024 * 1024 Bytes.
+  * ``KVM_STATS_UNIT_SECONDS``
+    It indicates that the statistics data is used to measure time/latency, in
+    the unit of nanosecond, microsecond, millisecond and second. The unit of the
+    data is determined by the ``exponent`` field in the descriptor. The
+    ``KVM_STATS_SCALE_POW10`` flag is valid in this case. The unit of the data
+    is determined by ``pow(10, exponent)``. For example, if value is 2000000,
+    ``exponent`` is -6, which means the unit of statistics data is microsecond,
+    we can get the statistics data in the unit of second by
+    ``value * pow(10, exponent) = 2000000 * pow(10, -6) = 2 seconds``.
+  * ``KVM_STATS_UNIT_CYCLES``
+    It indicates that the statistics data is used to measure CPU clock cycles.
+    The ``KVM_STATS_SCALE_POW10`` flag is valid in this case. For example, if
+    value is 200, ``exponent`` is 4, we can get the number of CPU clock cycles
+    by ``value * pow(10, exponent) = 200 * pow(10, 4) = 2000000``.
+
+The ``exponent`` field is the scale of corresponding statistics data. It has two
+values as follows:
+  * ``KVM_STATS_SCALE_POW10``
+    The scale is based on power of 10. It is used for measurement of time and
+    CPU clock cycles.
+  * ``KVM_STATS_SCALE_POW2``
+    The scale is based on power of 2. It is used for measurement of memory size.
+
+The ``size`` field is the number of values of this statistics data. It is in the
+unit of ``unsigned long`` for VCPU or ``__u64`` for VM.
+
+The ``unused1`` and ``unused2`` fields are reserved for future
+support for other types of statistics data, like log/linear histogram.
+
+The ``name`` field points to the name string of the statistics data. The name
+string starts at the end of ``struct kvm_stats_desc``.
+The maximum length (including trailing '\0') is indicated by ``name_size``
+in ``struct kvm_stats_header``.
+
+The Stats Data block contains an array of data values of type ``struct
+kvm_vm_stats_data`` or ``struct kvm_vcpu_stats_data``. It would be read by
+user space periodically to pull statistics data.
+The order of data value in Stats Data block is the same as the order of
+descriptors in Descriptors block.
+  * Statistics data for VM::
+
+	struct kvm_vm_stats_data {
+		unsigned long value[0];
+	};
+
+  * Statistics data for VCPU::
+
+	struct kvm_vcpu_stats_data {
+		__u64 value[0];
+	};
+
 5. The kvm_run structure
 ========================
 
@@ -6911,3 +7074,11 @@ Right now, the only bit that can be set is bit 12, corresponding
 to KVM_HC_PAGE_ENC_STATUS.  The hypercall returns ENOSYS if
 KVM_CAP_EXIT_HYPERCALL is not enabled or if bit 12 is not set when
 enabling it.
+
+8.34 KVM_CAP_STATS_BINARY_FD
+----------------------------
+
+:Architectures: all
+
+This capability indicates the feature that user space can create get a file
+descriptor for every VM and VCPU to read statistics data in binary format.
-- 
2.31.1.527.g47e6f16901-goog

