Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C6B363C48;
	Tue,  9 Jun 2026 21:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781041125; cv=none; b=CTGs1dKaUDZdoygXwqcc0q6uzn5zTNASIcq5SkuuLLvBUP9YaahJRmXvHoHp+KDFVpykHaeJDWnhqoBzvC76f4yIgzny9d5cT1ET6EhLYNKs39e/7bLaSdPwjvu3VYbDWNaAJQ3aU3zT77OJ2Tyo0cyfmKDajomQSqP4QjhCavo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781041125; c=relaxed/simple;
	bh=aKkdm66U5qp6BRQLUe+gWmTpEgt54D1Np2cYwd/h1HU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Gsru0QuGvLqhqUp2y83ZTGsZlgzIsRP78s8/Zv9kJ8tVUWu8VnR07wF2BDuWD2n1GaaE1R4OY/VPzMKn6v3zzys6IcaYG3CJoGR/ZCXSkGZ1YNUniE8hp9DSqZ5qWr4seXj+0QsWNedBwtUpp1nOXqcGOZRJKNJ1azJ+SEfbSTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jwH8AfK3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jwH8AfK3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23AFE1F00893;
	Tue,  9 Jun 2026 21:38:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781041122;
	bh=hGAzSqRF3yiz6I29e/qPV+How0w2oE1P/oo9xL36Cb8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jwH8AfK32u4gcg6S/8pnBTe4NfMM9r7vPSGStu5dp8hdTnui5dcuCl9DAW+T1NXXJ
	 UerKXsbIzLe3qO0VdGTKwH7sXN7/f6Gr3lmuTKzqOhpqP9kjHEnbG9aS1Hsp/Eal0e
	 iDN3yOA6TpfxyScSyEmbJlDr8B4XDDYkMkuIby0i2lNqIKeUqH0vctK1P6qgAhE5FA
	 6nyMQSArkFupzkCBaY3Bt6S4CjYOAmss1V+D1IAWsXmdNl3OBh+iE7CELioFrOYaTs
	 zsD2N4V7PB8DzTSv7rEfTHnKG9nr3mLdQNLZ8Dv8uQI+eqXwNbnReZ5sr2dK+o+xts
	 ubPhGXemwnUpw==
Date: Tue, 9 Jun 2026 15:38:40 -0600
From: Keith Busch <kbusch@kernel.org>
To: Farhan Ali <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org, alex@shazbot.org, helgaas@kernel.org,
	schnelle@linux.ibm.com, mjrosato@linux.ibm.com,
	Julian Ruess <julianr@linux.ibm.com>
Subject: Re: [PATCH v18 3/4] vfio/pci: Add a reset_done callback for vfio-pci
 driver
Message-ID: <aiiH4HQlW-ldojwQ@kbusch-mbp>
References: <20260603182415.2324-1-alifm@linux.ibm.com>
 <20260603182415.2324-4-alifm@linux.ibm.com>
 <aiE3I0bL0TX1nOec@kbusch-mbp>
 <d9ca420b-a1e6-4d12-bd42-3993e401d58b@linux.ibm.com>
 <aiHjIyYB_8ogbxfz@kbusch-mbp>
 <8d1cbef7-f7d9-4796-a6a1-460956adfb39@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d1cbef7-f7d9-4796-a6a1-460956adfb39@linux.ibm.com>

On Fri, Jun 05, 2026 at 11:41:07AM -0700, Farhan Ali wrote:
> But I am curious to learn about your thoughts for DPC/AER with vfio for
> other platforms (x86/ARM?). Thanks

Sure. I think we just need a checkpoint mechanism between the user and
kernel space, then the kernel's existing pci error recovery can proceed
as-is. No architecture specifics needed.

The below is a quick example of what I had in mind for the kernel side.
User space just needs to cooperate through the new feature here for this
to work.

---
commit f67c0a83a75ee5f69a116894cfedc5c6de7b2195
Author: Keith Busch <kbusch@kernel.org>
Date:   Wed Apr 22 17:11:21 2026 -0700

    vfio/pci: add error recovery handshake with userspace
    
    The existing VFIO PCI error handling fires an eventfd to notify
    userspace of an AER error but immediately returns CAN_RECOVER, allowing
    the kernel's AER recovery state machine to proceed with bus resets
    while userspace may still be actively accessing the device.
    
    Introduce VFIO_PCI_ERR_NOTIFY_IRQ_INDEX, a new IRQ index that userspace
    can register to opt into a proper error recovery handshake. When
    registered, the error_detected callback signals the eventfd and waits
    up to 60 seconds for userspace to acknowledge via VFIO_IRQ_SET_ACTION_UNMASK,
    giving userspace time to quiesce device access before the kernel proceeds
    with the reset. After the bus reset completes, the new slot_reset callback
    signals the same eventfd again so userspace knows the device is ready for
    reinitialization.
    
    The legacy VFIO_PCI_ERR_IRQ_INDEX behavior is preserved unchanged for
    backward compatibility with existing userspace drivers.
    
    Signed-off-by: Keith Busch <kbusch@kernel.org>

diff --git a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
index bb121f635b9f7..cd045003093b7 100644
--- a/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
+++ b/drivers/vfio/pci/hisilicon/hisi_acc_vfio_pci.c
@@ -1755,6 +1755,7 @@ static const struct pci_error_handlers hisi_acc_vf_err_handlers = {
 	.reset_prepare = hisi_acc_vf_pci_reset_prepare,
 	.reset_done = hisi_acc_vf_pci_aer_reset_done,
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.slot_reset = vfio_pci_aer_slot_reset,
 };
 
 static struct pci_driver hisi_acc_vfio_pci_driver = {
diff --git a/drivers/vfio/pci/mlx5/main.c b/drivers/vfio/pci/mlx5/main.c
index de306dee1d1ad..3262918abe5ed 100644
--- a/drivers/vfio/pci/mlx5/main.c
+++ b/drivers/vfio/pci/mlx5/main.c
@@ -1444,6 +1444,7 @@ MODULE_DEVICE_TABLE(pci, mlx5vf_pci_table);
 static const struct pci_error_handlers mlx5vf_err_handlers = {
 	.reset_done = mlx5vf_pci_aer_reset_done,
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.slot_reset = vfio_pci_aer_slot_reset,
 };
 
 static struct pci_driver mlx5vf_pci_driver = {
diff --git a/drivers/vfio/pci/nvgrace-gpu/main.c b/drivers/vfio/pci/nvgrace-gpu/main.c
index fa056b69f899a..6f3472e2ce11a 100644
--- a/drivers/vfio/pci/nvgrace-gpu/main.c
+++ b/drivers/vfio/pci/nvgrace-gpu/main.c
@@ -1273,6 +1273,7 @@ static void nvgrace_gpu_vfio_pci_reset_done(struct pci_dev *pdev)
 static const struct pci_error_handlers nvgrace_gpu_vfio_pci_err_handlers = {
 	.reset_done = nvgrace_gpu_vfio_pci_reset_done,
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.slot_reset = vfio_pci_aer_slot_reset,
 };
 
 static struct pci_driver nvgrace_gpu_vfio_pci_driver = {
diff --git a/drivers/vfio/pci/pds/pci_drv.c b/drivers/vfio/pci/pds/pci_drv.c
index 4923f18231263..50aba9e703ed0 100644
--- a/drivers/vfio/pci/pds/pci_drv.c
+++ b/drivers/vfio/pci/pds/pci_drv.c
@@ -174,6 +174,7 @@ static void pds_vfio_pci_aer_reset_done(struct pci_dev *pdev)
 static const struct pci_error_handlers pds_vfio_pci_err_handlers = {
 	.reset_done = pds_vfio_pci_aer_reset_done,
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.slot_reset = vfio_pci_aer_slot_reset,
 };
 
 static struct pci_driver pds_vfio_pci_driver = {
diff --git a/drivers/vfio/pci/qat/main.c b/drivers/vfio/pci/qat/main.c
index ac9652539d66a..dc83b52162bbf 100644
--- a/drivers/vfio/pci/qat/main.c
+++ b/drivers/vfio/pci/qat/main.c
@@ -683,6 +683,7 @@ MODULE_DEVICE_TABLE(pci, qat_vf_vfio_pci_table);
 static const struct pci_error_handlers qat_vf_err_handlers = {
 	.reset_done = qat_vf_pci_aer_reset_done,
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.slot_reset = vfio_pci_aer_slot_reset,
 };
 
 static struct pci_driver qat_vf_vfio_pci_driver = {
diff --git a/drivers/vfio/pci/vfio_pci_core.c b/drivers/vfio/pci/vfio_pci_core.c
index ad52abc46c04d..b2de978ac5221 100644
--- a/drivers/vfio/pci/vfio_pci_core.c
+++ b/drivers/vfio/pci/vfio_pci_core.c
@@ -738,8 +738,11 @@ void vfio_pci_core_close_device(struct vfio_device *core_vdev)
 
 	vfio_pci_dma_buf_cleanup(vdev);
 
+	complete(&vdev->err_notify_ack);
+
 	mutex_lock(&vdev->igate);
 	vfio_pci_eventfd_replace_locked(vdev, &vdev->err_trigger, NULL);
+	vfio_pci_eventfd_replace_locked(vdev, &vdev->err_notify_trigger, NULL);
 	vfio_pci_eventfd_replace_locked(vdev, &vdev->req_trigger, NULL);
 	mutex_unlock(&vdev->igate);
 }
@@ -785,7 +788,8 @@ static int vfio_pci_get_irq_count(struct vfio_pci_core_device *vdev, int irq_typ
 
 			return (flags & PCI_MSIX_FLAGS_QSIZE) + 1;
 		}
-	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX) {
+	} else if (irq_type == VFIO_PCI_ERR_IRQ_INDEX ||
+		   irq_type == VFIO_PCI_ERR_NOTIFY_IRQ_INDEX) {
 		if (pci_is_pcie(vdev->pdev))
 			return 1;
 	} else if (irq_type == VFIO_PCI_REQ_IRQ_INDEX) {
@@ -2105,6 +2109,7 @@ int vfio_pci_core_init_dev(struct vfio_device *core_vdev)
 		return ret;
 	INIT_LIST_HEAD(&vdev->dmabufs);
 	init_rwsem(&vdev->memory_lock);
+	init_completion(&vdev->err_notify_ack);
 	xa_init(&vdev->ctx);
 
 	return 0;
@@ -2242,16 +2247,53 @@ pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 {
 	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
 	struct vfio_pci_eventfd *eventfd;
+	unsigned long timeout;
+
+	rcu_read_lock();
+	eventfd = rcu_dereference(vdev->err_notify_trigger);
+	if (!eventfd) {
+		eventfd = rcu_dereference(vdev->err_trigger);
+		if (eventfd)
+			eventfd_signal(eventfd->ctx);
+		rcu_read_unlock();
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	}
+
+	reinit_completion(&vdev->err_notify_ack);
+	eventfd_signal(eventfd->ctx);
+	rcu_read_unlock();
+
+	timeout = wait_for_completion_timeout(&vdev->err_notify_ack,
+					      msecs_to_jiffies(60000));
+	if (!timeout) {
+		pci_warn(pdev, "vfio error handler timed out waiting for userspace ack\n");
+		return PCI_ERS_RESULT_CAN_RECOVER;
+	}
 
 	rcu_read_lock();
-	eventfd = rcu_dereference(vdev->err_trigger);
+	eventfd = rcu_dereference(vdev->err_notify_trigger);
+	rcu_read_unlock();
+	if (!eventfd)
+		return PCI_ERS_RESULT_CAN_RECOVER;
+
+	return PCI_ERS_RESULT_NEED_RESET;
+}
+EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
+
+pci_ers_result_t vfio_pci_aer_slot_reset(struct pci_dev *pdev)
+{
+	struct vfio_pci_core_device *vdev = dev_get_drvdata(&pdev->dev);
+	struct vfio_pci_eventfd *eventfd;
+
+	rcu_read_lock();
+	eventfd = rcu_dereference(vdev->err_notify_trigger);
 	if (eventfd)
 		eventfd_signal(eventfd->ctx);
 	rcu_read_unlock();
 
-	return PCI_ERS_RESULT_CAN_RECOVER;
+	return PCI_ERS_RESULT_RECOVERED;
 }
-EXPORT_SYMBOL_GPL(vfio_pci_core_aer_err_detected);
+EXPORT_SYMBOL_GPL(vfio_pci_aer_slot_reset);
 
 int vfio_pci_core_sriov_configure(struct vfio_pci_core_device *vdev,
 				  int nr_virtfn)
@@ -2317,6 +2359,7 @@ EXPORT_SYMBOL_GPL(vfio_pci_core_sriov_configure);
 
 const struct pci_error_handlers vfio_pci_core_err_handlers = {
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.slot_reset = vfio_pci_aer_slot_reset,
 };
 EXPORT_SYMBOL_GPL(vfio_pci_core_err_handlers);
 
diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 33944d4d9dc43..d3a32d3695f0a 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -811,6 +811,31 @@ static int vfio_pci_set_err_trigger(struct vfio_pci_core_device *vdev,
 					       count, flags, data);
 }
 
+static int vfio_pci_set_err_notify_trigger(struct vfio_pci_core_device *vdev,
+					   unsigned index, unsigned start,
+					   unsigned count, uint32_t flags,
+					   void *data)
+{
+	if (index != VFIO_PCI_ERR_NOTIFY_IRQ_INDEX || start != 0 || count > 1)
+		return -EINVAL;
+
+	return vfio_pci_set_ctx_trigger_single(vdev,
+					       &vdev->err_notify_trigger,
+					       count, flags, data);
+}
+
+static int vfio_pci_set_err_notify_unmask(struct vfio_pci_core_device *vdev,
+					  unsigned index, unsigned start,
+					  unsigned count, uint32_t flags,
+					  void *data)
+{
+	if (index != VFIO_PCI_ERR_NOTIFY_IRQ_INDEX || start != 0 || count != 0)
+		return -EINVAL;
+
+	complete(&vdev->err_notify_ack);
+	return 0;
+}
+
 static int vfio_pci_set_req_trigger(struct vfio_pci_core_device *vdev,
 				    unsigned index, unsigned start,
 				    unsigned count, uint32_t flags, void *data)
@@ -864,6 +889,18 @@ int vfio_pci_set_irqs_ioctl(struct vfio_pci_core_device *vdev, uint32_t flags,
 			break;
 		}
 		break;
+	case VFIO_PCI_ERR_NOTIFY_IRQ_INDEX:
+		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
+		case VFIO_IRQ_SET_ACTION_TRIGGER:
+			if (pci_is_pcie(vdev->pdev))
+				func = vfio_pci_set_err_notify_trigger;
+			break;
+		case VFIO_IRQ_SET_ACTION_UNMASK:
+			if (pci_is_pcie(vdev->pdev))
+				func = vfio_pci_set_err_notify_unmask;
+			break;
+		}
+		break;
 	case VFIO_PCI_REQ_IRQ_INDEX:
 		switch (flags & VFIO_IRQ_SET_ACTION_TYPE_MASK) {
 		case VFIO_IRQ_SET_ACTION_TRIGGER:
diff --git a/drivers/vfio/pci/virtio/main.c b/drivers/vfio/pci/virtio/main.c
index d2e5cbca13c85..8ca48140d0f0c 100644
--- a/drivers/vfio/pci/virtio/main.c
+++ b/drivers/vfio/pci/virtio/main.c
@@ -212,6 +212,7 @@ static void virtiovf_pci_aer_reset_done(struct pci_dev *pdev)
 static const struct pci_error_handlers virtiovf_err_handlers = {
 	.reset_done = virtiovf_pci_aer_reset_done,
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.slot_reset = vfio_pci_aer_slot_reset,
 };
 
 static struct pci_driver virtiovf_pci_driver = {
diff --git a/drivers/vfio/pci/xe/main.c b/drivers/vfio/pci/xe/main.c
index 4ecadbbfd86ec..f7158d3913740 100644
--- a/drivers/vfio/pci/xe/main.c
+++ b/drivers/vfio/pci/xe/main.c
@@ -143,6 +143,7 @@ static const struct pci_error_handlers xe_vfio_pci_err_handlers = {
 	.reset_prepare = xe_vfio_pci_reset_prepare,
 	.reset_done = xe_vfio_pci_reset_done,
 	.error_detected = vfio_pci_core_aer_err_detected,
+	.slot_reset = vfio_pci_aer_slot_reset,
 };
 
 static int xe_vfio_pci_open_device(struct vfio_device *core_vdev)
diff --git a/include/linux/vfio_pci_core.h b/include/linux/vfio_pci_core.h
index 2ebba746c18f7..74ede0c9f7bd4 100644
--- a/include/linux/vfio_pci_core.h
+++ b/include/linux/vfio_pci_core.h
@@ -131,6 +131,8 @@ struct vfio_pci_core_device {
 	struct pci_saved_state	*pm_save;
 	int			ioeventfds_nr;
 	struct vfio_pci_eventfd __rcu *err_trigger;
+	struct vfio_pci_eventfd __rcu *err_notify_trigger;
+	struct completion	err_notify_ack;
 	struct vfio_pci_eventfd __rcu *req_trigger;
 	struct eventfd_ctx	*pm_wake_eventfd_ctx;
 	struct list_head	dummy_resources_list;
@@ -191,6 +193,7 @@ void vfio_pci_core_finish_enable(struct vfio_pci_core_device *vdev);
 int vfio_pci_core_setup_barmap(struct vfio_pci_core_device *vdev, int bar);
 pci_ers_result_t vfio_pci_core_aer_err_detected(struct pci_dev *pdev,
 						pci_channel_state_t state);
+pci_ers_result_t vfio_pci_aer_slot_reset(struct pci_dev *pdev);
 ssize_t vfio_pci_core_do_io_rw(struct vfio_pci_core_device *vdev, bool test_mem,
 			       void __iomem *io, char __user *buf,
 			       loff_t off, size_t count, size_t x_start,
diff --git a/include/uapi/linux/vfio.h b/include/uapi/linux/vfio.h
index 5de618a3a5eee..9ce3d17c6d755 100644
--- a/include/uapi/linux/vfio.h
+++ b/include/uapi/linux/vfio.h
@@ -645,6 +645,7 @@ enum {
 	VFIO_PCI_MSIX_IRQ_INDEX,
 	VFIO_PCI_ERR_IRQ_INDEX,
 	VFIO_PCI_REQ_IRQ_INDEX,
+	VFIO_PCI_ERR_NOTIFY_IRQ_INDEX,
 	VFIO_PCI_NUM_IRQS
 };
 
--
